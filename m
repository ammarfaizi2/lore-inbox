Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVA3STh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVA3STh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVA3STg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:19:36 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:29704
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261758AbVA3STR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:19:17 -0500
Date: Sun, 30 Jan 2005 10:19:13 -0800
From: Phil Oester <kernel@linuxace.com>
To: Patrick McHardy <kaber@trash.net>, "David S. Miller" <davem@davemloft.net>,
       Robert.Olsson@data.slu.se, akpm@osdl.org, torvalds@osdl.org,
       alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050130181913.GA15299@linuxace.com>
References: <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127123326.2eafab35.davem@davemloft.net> <20050128001701.D22695@flint.arm.linux.org.uk> <20050127163444.1bfb673b.davem@davemloft.net> <20050128085858.B9486@flint.arm.linux.org.uk> <20050130132343.A25000@flint.arm.linux.org.uk> <41FD17FE.6050007@trash.net> <41FD18C5.6090108@trash.net> <20050130180146.E25000@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130180146.E25000@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 06:01:46PM +0000, Russell King wrote:
> > OTOH, if conntrack isn't loaded forwarded packet are never defragmented,
> > so frag_list should be empty. So probably false alarm, sorry.
> 
> I've just checked Phil's mails - both Phil and myself are using
> netfilter on the troublesome boxen.
> 
> Also, since FragCreates is zero, and this does mean that the frag_list
> is not empty in all cases so far where ip_fragment() has been called.
> (Reading the code, if frag_list was empty, we'd have to create some
> fragments, which increments the FragCreates statistic.)

The below testcase seems to illustrate the problem nicely -- ip_dst_cache
grows but never shrinks:

On gateway:

iptables -I FORWARD -d 10.10.10.0/24 -j DROP

On client:

for i in `seq 1 254` ; do ping -s 1500 -c 5 -w 1 -f 10.10.10.$i ; done


Phil
