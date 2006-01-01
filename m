Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWAALuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWAALuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 06:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWAALuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 06:50:13 -0500
Received: from main.gmane.org ([80.91.229.2]:16814 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750730AbWAALuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 06:50:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Howto set kernel makefile to use particular gcc
Date: Sun, 01 Jan 2006 20:49:50 +0900
Message-ID: <dp8fku$bdr$1@sea.gmane.org>
References: <20060101121303.488e634b@vaio.gigerstyle.ch>	<23377.1136114307@ocs3.ocs.com.au> <20060101123729.09c5d76c@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <20060101123729.09c5d76c@vaio.gigerstyle.ch>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You never know where you'll get most response:-)

Marc Giger wrote:
> Keith, your domain seems not to be resolvable...
Yup... very strange. Not proper delegation to zoneedit.com?

kalin@kpc ~ $ whois ocs.com.au |grep ^Name
Name Server:             ns2.zoneedit.com
Name Server:             ns3.zoneedit.com
Name Server:             ns1.ocs.com.au
Name Server IP:          202.147.117.210

kalin@kpc ~ $ dnsq any ocs.com.au ns2.zoneedit.com
255 ocs.com.au:
167 bytes, 1+4+2+0 records, response, authoritative, noerror
query: 255 ocs.com.au
answer: ocs.com.au 7200 A 0.0.0.0
#                     --> H E R E <--
answer: ocs.com.au 7200 NS ns2.zoneedit.com
answer: ocs.com.au 7200 NS ns3.zoneedit.com
answer: ocs.com.au 7200 SOA ns2.zoneedit.com soacontact.zoneedit.com 1135991510
14400 7200 950400 7200
authority: ocs.com.au 7200 NS ns2.zoneedit.com
authority: ocs.com.au 7200 NS ns3.zoneedit.com

kalin@kpc ~ $ dnsq any ocs.com.au 202.147.117.210
255 ocs.com.au:
221 bytes, 1+5+0+4 records, response, authoritative, noerror
query: 255 ocs.com.au
answer: ocs.com.au 172800 SOA mail.ocs.com.au admin.mail.ocs.com.au 2005123101 1
0800 3600 604800 86400
answer: ocs.com.au 172800 MX 0 mail.ocs.com.au
answer: ocs.com.au 172800 NS ns1.ocs.com.au
answer: ocs.com.au 172800 NS ns2.zoneedit.com
answer: ocs.com.au 172800 NS ns3.zoneedit.com
additional: mail.ocs.com.au 172800 A 202.147.117.210
additional: ns1.ocs.com.au 172800 A 202.147.117.210
additional: ns2.zoneedit.com 158763 A 69.72.158.226
additional: ns3.zoneedit.com 158763 A 66.180.174.61

kalin@kpc ~ $ dnsname 202.147.117.210
mail.ocs.com.au

> On Sun, 01 Jan 2006 22:18:27 +1100
> Keith Owens <kaos@ocs.com.au> wrote:
> 
> 
>>Marc Giger (on Sun, 1 Jan 2006 12:13:03 +0100) wrote:
>>
>>>Why would you "hardwire" it?
>>>#export CC="distcc"
>>>should do it.
>>
>>Doubt it.  From 'info make', Node: Environment.
>>
>>   Variables in `make' can come from the environment in which `make'
>>   is
>>  run.  Every environment variable that `make' sees when it starts up
>>  is transformed into a `make' variable with the same name and value.
>>  But an explicit assignment in the makefile, or with a command
>>  argument, overrides the environment.  (If the `-e' flag is
>>  specified, then values from the environment override assignments in
>>  the makefile.  *Note Summary of Options: Options Summary.  But this
>>  is not recommended practice.)
>>
>>The kernel Makefile explicitly sets CC which overrides the environment
>>value, but does not override a command line definition of CC.  IOW, do
>>not reply on environment variables always working with make.
> 
> 
> You are absolutely right. Because I never used it in this way, I wrote
> "should":-) I specify it always on the make command line.
> 
> So if Kalin would like to hardwire it, he has to change the CC variable
> in the Makefile...
My point was that changing it in the Makefile does not work.

kpc ~ # grep CC= /usr/src/linux/Makefile
CC=distcc
# echo $CC

kpc ~ # uname -a
Linux kpc 2.6.14.4-K01_P4_desktop #1 Sun Dec 18 22:46:08 JST 2005 i686 Intel(R) Pentium(R) 4 CPU
2.40GHz GenuineIntel GNU/Linux

What I want is making a bunch of kernels in NFS exported /var/kernels/out/`uname -r` and then be
able to `make modules` on other machines without having to recompile the whole thing. All (or
almost?) boxes use gcc-3.4.4 and distcc to share the load.

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

