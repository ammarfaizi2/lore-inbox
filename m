Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291460AbSBHIEG>; Fri, 8 Feb 2002 03:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291456AbSBHID4>; Fri, 8 Feb 2002 03:03:56 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:23570 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291455AbSBHIDr>; Fri, 8 Feb 2002 03:03:47 -0500
Date: Fri, 8 Feb 2002 09:03:42 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre9: iptables screwed?
Message-ID: <20020208080342.GB12130@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 08:24:28PM -0800, H. Peter Anvin wrote:

> I get the following error with iptables on 2.4.18-pre9:
> 
> sudo iptables-restore < /etc/sysconfig/iptables
> iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> Abort (core dumped)
> 
> However, if I apply the rules manually (using iptables), I have no
> problem; only if I'm using iptables-save or iptables-restore do I get
> a dump...

I have this since the netfilter update from pre6 or pre7...

It seems to be caused by a change in the logic for the mangle table:
the userspace tools check only for PREROUTING and OUTPUT chains
(the 1 << 0 | 1 << 3 check), but the kernel code was recently updated
to support more chains in this table (POSTROUTING etc).

So it would seem that we need to have a more recent version of 
the userspace tools (CVS maybe, since the latest released version
has the same bug), or the netfilter people should check the
userspace tools version before introducing this kind of 
incompatible change.

(BTW, the quick and dirty fix for me was to hand edit 
/etc/sysconfig/iptables and remove all references to the mangle table,
since I don't use it).

That being said, IANANG (netfilter guru) :-)

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
