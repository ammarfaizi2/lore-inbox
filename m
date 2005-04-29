Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVD2V0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVD2V0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVD2VZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:25:43 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:39828 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S262991AbVD2VW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:22:26 -0400
Message-ID: <4272A582.3040709@austin.rr.com>
Date: Fri, 29 Apr 2005 16:22:10 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: which ioctls matter across filesystems
References: <42728964.8000501@austin.rr.com> <1114804426.12692.49.camel@lade.trondhjem.org> <1114805033.6682.150.camel@betsy> <1114807360.12692.77.camel@lade.trondhjem.org> <1114807648.6682.153.camel@betsy> <1114809199.12692.96.camel@lade.trondhjem.org>
In-Reply-To: <1114809199.12692.96.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>I think what the IETF NFS working group rather needs right now is an
>advocate that is willing to stand up and demonstrate why protocol
>support for inotify-style callbacks would be a more scalable solution
>than a solution based on a combination of GETATTR polling and read
>delegations (essentially the same thing as CIFS' op-locks) for
>directories.
>
>  
>
I agree.

>The current research (see
>http://www3.ietf.org/proceedings/05mar/slides/nfsv4-4/sld1.htm) which
>has uses real-life on-the-wire traffic actually leans more towards the
>GETATTR solution. That research was based on a set of anonymous tcpdump
>traces taken at Harvard University, though, so it reflects the traffic
>in a typical university environment. It may be that other use-cases
>exist that favour the inotify callbacks case.
>  
>
Very interesting, I had not seen that.   FYI - There are many years of 
real world experience on the current transact2 notify (it is deployed in 
some form on most clients) but I don't know whether one of the NAS 
storage companies or researchers has done a good research paper on this 
topic - although there is no lack of customer traces in SPEC and SNIA.

My gut reaction is that as
1) directory size increases (number of files per directory)
and
2) change rate goes down

(both of which could be client heuristics) the notify mechanism (on the 
directory, or parent directory) is much better, but with small 
directories and more frequent changes the getattr (Transact2 
QueryPathinfo) approach wins.   There is no one-size-fits-all that 
covers both cases.
