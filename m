Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTLFRiu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 12:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbTLFRiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 12:38:50 -0500
Received: from ppp-RAS1-3-87.dialup.eol.ca ([64.56.226.87]:7296 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S265215AbTLFRis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 12:38:48 -0500
Date: Sat, 6 Dec 2003 12:38:50 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031206173850.GB362@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <fa.jiqirm0.13gv2u@ifi.uio.no> <fa.f9f2gij.1kua0f@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.f9f2gij.1kua0f@ifi.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 10:59:01AM +0000, William Lee Irwin III wrote:
> This leads to a similar conclusion to Stian Jordet's case. It's not
> mistaking you for HT, it's the lack of an internal distinction between
> the cases that need and don't need irq balancing.

I have VP6 (Apollo Pro 133A, 82c694X/686B) dual-P3 (800MHz/133MHz).  I'm
currently using MPS 1.1, because USB doesn't work with MPS 1.4 (or, it
does but only with 'noapic').  And, I can report the same finding as
others.

Before:
-------
           CPU0       CPU1       
  0:      79365         63    IO-APIC-edge  timer
  1:        215          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:       8654          0    IO-APIC-edge  serial
  8:          1          1    IO-APIC-edge  rtc
 12:         52          1    IO-APIC-edge  i8042
 14:       2155          0    IO-APIC-edge  ide0
 15:          2          0    IO-APIC-edge  ide1
 17:          0          0   IO-APIC-level  eth0
NMI:          0          0 
LOC:      79231      79266 
ERR:          0
MIS:          0

After 'noirqbalance':
---------------------
           CPU0       CPU1       
  0:      15039      16025    IO-APIC-edge  timer
  1:         47         75    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:         21         43    IO-APIC-edge  serial
  8:          2          0    IO-APIC-edge  rtc
 12:         21         32    IO-APIC-edge  i8042
 14:        828        410    IO-APIC-edge  ide0
 15:          2          0    IO-APIC-edge  ide1
 17:          0          0   IO-APIC-level  eth0
NMI:          0          0 
LOC:      30865      30900 
ERR:          0
MIS:          0

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
Linux solution for data management and processing. 
