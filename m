Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUEADlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUEADlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 23:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUEADlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 23:41:22 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:14988 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261786AbUEADlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 23:41:20 -0400
Message-ID: <40931C56.4030500@yahoo.com.au>
Date: Sat, 01 May 2004 13:41:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <Fabian.Frederick@skynet.be>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 2.6.6-rc3-mm1] Add maxthinktime to sysfs
References: <1083364002.6303.9.camel@bluerhyme.real3>	 <20040430154246.2019f9ec.akpm@osdl.org> <1083368224.4976.9.camel@bluerhyme.real3>
In-Reply-To: <1083368224.4976.9.camel@bluerhyme.real3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:
> On Sat, 2004-05-01 at 00:42, Andrew Morton wrote:

>>Badari, did you find any need to vary this in the AS tuning work which you
>>were doing?  (What happened to that, btw?)
>>
>>If we're going to expose this tunable to users it needs to be documented in
>>as-iosched.txt
> 
> 
> I'm an absolute beginner Andrew ... Maybe someone more experienced could do that ?
> 

No no, writing end user documentation is much easier than writing
kernel code!

But either way you needn't worry about it because this isn't something
that you would want to tweak from userspace really. If you find it
useful to do some tuning then I guess it can go in -mm.

> PS:Attached the patch v2.
> 
> Best regards,
> Fabian
> 
> 
> ------------------------------------------------------------------------
> 
> ffbench 11 - Fabian Frederick 04/2004 - asio - maxthinktime - 10 clients
> 5	100	300
> ---------------------
> 5.37	21.26	16.28
> 11.71	23.10	20.14
> 15.22	21.05	20.20
> 13.85	18.03	17.55
> 11.58	16.39	16.86
...

maxthinktime of 5 is below the default antic_expire of 6. This
basically turns off the thinktime heuristic, so it isn't really
surprising that it runs like crap.

The *minimum* maxthinktime you should be playing with is probably
about double the antic_expire value.

Raising the value will make the heuristic a bit more restrictive
which could be a good idea. I think OSDL's STP has a couple of
database tests where the anticipatory scheduler has a small
regression (dbt2, dbt3). They might be helpful to you.
