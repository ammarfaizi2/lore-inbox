Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbUB2XHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 18:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUB2XGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 18:06:46 -0500
Received: from imap.gmx.net ([213.165.64.20]:48085 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262175AbUB2XGn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 18:06:43 -0500
X-Authenticated: #1226656
Date: Mon, 1 Mar 2004 00:06:41 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: mru@kth.se (=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: kernel unaligned acc on Alpha
Message-Id: <20040301000641.3d54ff39.gigerstyle@gmx.ch>
In-Reply-To: <20040229230318.493034b2.gigerstyle@gmx.ch>
References: <20040229215546.065f42e9.gigerstyle@gmx.ch>
	<yw1xvflp1sv6.fsf@kth.se>
	<20040229230318.493034b2.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004 23:03:18 +0100
Marc Giger <gigerstyle@gmx.ch> wrote:

> Hi Måns,
> 
> On Sun, 29 Feb 2004 22:24:45 +0100
> mru@kth.se (Måns Rullgård) wrote:
> 
> > Marc Giger <gigerstyle@gmx.ch> writes:
> > 
> > > Hi All,
> > >
> > > I have a lot of unaligned accesses in kernel space:
> > >
> > > kernel unaligned acc    : 2191330
> > > (pc=fffffffc002557d8,va=fffffffc00256059)
> > >
> > > It seems to be located in the networking part (iptables?) from the
> > > kernel. Can someone please help me how to find the location of
> > > these uac's? I already have recompiled the kernel with debugging
> > > enabled and tried to debug it with gdb. 
> > 
> > Find the matching function in System.map.  Look for the entry with
> > the highest address less than or equal to the pc value.
> 
> The highest address in System.map is 
> fffffc000076fab0 A _end
> 
> /proc/ksyms is more informative. It seems the function is in a
> module.
> 
> fffffffc00254800 ipt_unregister_table   [ip_tables]
> fffffffc00256051 __insmod_ip_tables_S.rodata_L16        [ip_tables]
> 
> ipt_unregister_table is the most matching funtion, but makes no sense
> to me, since I don't load and unload it 2191330 times:-)
> 
> Do you have more tips how to find the right funtion in the modules?
> 

Ok, I found it, because in 2.4.25 (2.6 too) is already fixed.

It would be nice if you could explain me how to find a function in a
module with the given address.

Thank you and sorry for wasting your time!

Regards

Marc
