Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCLIcf>; Mon, 12 Mar 2001 03:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRCLIcZ>; Mon, 12 Mar 2001 03:32:25 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:31973 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S129598AbRCLIcT>; Mon, 12 Mar 2001 03:32:19 -0500
Message-ID: <3AAC8862.3461A1A8@mvista.com>
Date: Mon, 12 Mar 2001 00:27:14 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: mingo@elte.hu, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog
In-Reply-To: <20142.984376327@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 11 Mar 2001 20:43:16 -0800,
> george anzinger <george@mvista.com> wrote:
> >Consider this.  Why not use the NMI to sync the cpus.  Kdb would have a
> >function that is called each NMI.
> 
> kdb uses NMI IPI to get the other cpu's attention.  One cpu is in
> control and may or may not be accepting NMI, it depends on the event
> that entered kdb.  The other cpus end up in kdb code, spinning waiting
> for a cpu switch.  Initially they are not receiving NMI because they
> were invoked via NMI which is masked until they exit.  However if the
> user does a cpu switch then single steps the interrupted code, the cpu
> has to return from the NMI handler to the interrupted code at which
> time this cpu starts receiving NMI again.

Are you actually twiddling the hardware, or just changing what happens
on NMI?
> 
> The kdb context can change from ignoring NMI to accepting NMI.  It is
> easier to bring all the cpus into kdb and let the kdb code decide if it
> ignores any NMI that is being received.

Yes. Exactly.

George
