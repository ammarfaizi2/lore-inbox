Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268232AbUH2SOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268232AbUH2SOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 14:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUH2SOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 14:14:02 -0400
Received: from nysv.org ([213.157.66.145]:25538 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S268232AbUH2SNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 14:13:54 -0400
Date: Sun, 29 Aug 2004 21:12:10 +0300
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Spam <spam@tnonline.net>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Hans Reiser <reiser@namesys.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829181210.GD26192@nysv.org>
References: <1732169380.20040827224404@tnonline.net> <200408291521.i7TFLsQk028363@localhost.localdomain> <10558145.20040829185217@tnonline.net> <16690.4288.260815.847844@thebsh.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16690.4288.260815.847844@thebsh.namesys.com>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This will probably go down in history as the most pointless message
  ever, I just told Nik on IRC I'd take it up on the list :) ]

On Sun, Aug 29, 2004 at 09:22:08PM +0400, Nikita Danilov wrote:
>Spam writes:

>Hmm... drag-and-drop also doesn't work constently over all
>applications. Let's put it into kernel.

What I'm after is that the file system should be able to store
any arbitrary metadata. No matter what the format is.

Maybe I was a bit harsh on XML in my previous email, but whatever.

>Seriously, kernel prformance is critical to the system, and to achieve
>high performance all kernel code runs in single address space (actually,
>in portion of address spaces of user processes shared by all
>processes). All shared system state is located there. This means that
>bug in a kernel affects whole system. This means that kernel should be
>kept as simple as possible (and a bit more simple).

I do agree here. But is it seriously such a big issue to implement
the files-as-dirs kind of thing?

Be it overloading MAY_READ so it works with chdir or implementing openat
or whatever it takes.

I don't think this should be much more, if any more, than the capability
to store this data. Which Reiser4 does. But moved from the Reiser4
level to the VFS level. Right?

>This is why only things that cannot be done efficiently in the user
>level are put into kernel. And political agendas of various camps of
>user-level developers change nothing here.

What I'd want to do is to be able to write a Reiser4 plugin that suits
my needs for something. Not that I'd even know how to, but that's a
matter of time.

Are there other means of doing this than Reiser? I mean Reiser4 plugin
functionality by other means.

>>   Still.  Why do you oppose plugins, streams and meta files? The could
>>   be   valuable   and  easy  to use tools for many purposes. One could
>>   be  would be advanced ACLs defined as a meta-file using XML format.
>POSIX has standard ACL API in C (well, "eternal draft" only), one can
>use it to extract ACLs from kernel and convert it to any format to one's
>heart content. Advantage of this is that when XML goes out of fashion (I
>hope this wouldn't yet happen when you will read this message), kernel
>API will remain intact.

Aa, this apparently is an argument against XML parsing in the kernel,
not the idea that if someone wanted ACLs, that are in XML format, and
could not use them (because the kernel doesn't parse), he should be
able to write such a plugin.

Besides, let's say the Reiser4 XML-ACL plugin has a parser that actually
DOES something. For argument's sake. Would it not be up to the individual
user to disable this plugin? I'd assume it's possible to write plugins
so that they do not affect anything but themselves, meaning this parser.

Of course the problem of copying a file with XML-ACLs to another Reiser4
fs without support for them should be thought of. But I guess this is
where you take the shortest route; the XML-ACL files are intact in the
file's metadata, but totally unusable?

-- 
mjt

