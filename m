Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbSIVBNH>; Sat, 21 Sep 2002 21:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275993AbSIVBNH>; Sat, 21 Sep 2002 21:13:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55053 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275990AbSIVBNG>; Sat, 21 Sep 2002 21:13:06 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Date: Sun, 22 Sep 2002 01:21:06 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <amj5u2$20t$1@penguin.transmeta.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <20020920231112.GC24813@kroah.com> <3D8BDF9A.305@pacbell.net> <20020921033137.GA26017@kroah.com>
X-Trace: palladium.transmeta.com 1032657488 3976 127.0.0.1 (22 Sep 2002 01:18:08 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 22 Sep 2002 01:18:08 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020921033137.GA26017@kroah.com>, Greg KH  <greg@kroah.com> wrote:
>On Fri, Sep 20, 2002 at 07:55:22PM -0700, David Brownell wrote:
>> 
>> How about a facility to create the character (or block?) special file
>> node right there in the driverfs directory?  Optional of course.
>
>No, Linus has stated that this is not ok to do.  See the lkml archives
>for the whole discussion about this.

I'm not totally against it, it's just that it has some issues:

 - naming policy in general. Trivially handled by just always calling
   the special node something truly boring and nautral like "node", and
   be done with it. The _path_ is the real name, the "node" would be
   just an openable entity.

 - the issue of persistent permissions and ownership. 

The latter is the real problem.  And I personally think the only sane
policy is to just let "/sbin/hotplug" handle it, which definitely
implies _not_ having the kernel create the real device node. That way
user-space can have any policy it damn well pleases, including having
some default heuristics along with "a priori known nodes".

But clearly that user-space hotplug entity needs to know major and minor
numbers in order to create the real device node, and that's where the
"node" thing may be acceptable - as a template, nothing more.  Although
I suspect that there are other, simpler and more acceptable templates
(ie export the dang thing as just a "node" text-file, which describes
the majors and minors and "char vs block" issues)

		Linus
