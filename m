Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132589AbRDYVQd>; Wed, 25 Apr 2001 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRDYVQX>; Wed, 25 Apr 2001 17:16:23 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:36267 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132556AbRDYVQN>; Wed, 25 Apr 2001 17:16:13 -0400
Date: Wed, 25 Apr 2001 16:16:10 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104252116.QAA46520@tomcat.admin.navo.hpc.mil>
To: tim@tjansen.de, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
In-Reply-To: <01042522404901.00954@cookie>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Jansen <tim@tjansen.de>:
> On Wednesday 25 April 2001 21:37, you wrote:
> > Personally, I think
> >> 	proc_printf(fragment, "%d %d",get_portnum(usbdev), usbdev->maxchild);
> > is shorter (and faster) to parse with
> > 	fscanf(input,"%d %d",&usbdev,&maxchild);
> 
> Right, but what happens if you need to extend the format? For example 
> somebody adds support for USB 2.0 to the kernel and you need to some new 
> values. Then you would have the choice between changing the format and 
> breaking applications or keeping the format and dont provide the additional 
> information. 
> With XML (or single-value-per-file) it is easy to tell application to ignore 
> unknown tags (or files). When you just list values you will be damned sooner 
> or later, unless you make up additional rules that say how apps should handle 
> these cases. And then your approach is no longer simple, but possibly even 
> more complicated

Not necessarily. If the "extended data" is put following the current data
(since the data is currently record oriented) just making the output
format longer will not/should not casue problems in reading the data.
Just look at FORTRAN for an example of a extensible input :-) More data
on the record will/should just be ignored. The only coding change might
be to use a fgets to read a record, followed by a sscanf to get the known
values.

Alternatively, you can always put one value per record:
	tag:value
	tag2:value2...

This is still simpler than XML to read, and to generate.

The problem with this and XML is the same - If the tag is no longer relevent
(or changes its name), then the output must either continue to include it, or
break applications that depend on that tag.

In all cases, atomic extraction of the structured data will be problematical
since there may be buffering issues in output. XML is very verbose, and the
tagged format better; but a series of values goes even farther...

Try them out - Just go through the /proc/net formats and stick in the
XML... Just don't count on the regular utilities to decode them. It would
give some actual results to compair with the current structure.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
