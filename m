Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272406AbRH3TAT>; Thu, 30 Aug 2001 15:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272407AbRH3TAJ>; Thu, 30 Aug 2001 15:00:09 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:38532 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S272406AbRH3S76>;
	Thu, 30 Aug 2001 14:59:58 -0400
Date: Thu, 30 Aug 2001 14:59:43 -0400
From: Theodore Tso <tytso@mit.edu>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] serial.c ALI/SMSC/VIA high speed support
Message-ID: <20010830145943.B3114@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Marek Michalkiewicz <marekm@amelek.gda.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15azR5-0006Za-00@mm.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E15azR5-0006Za-00@mm.amelek.gda.pl>; from marekm@amelek.gda.pl on Sun, Aug 26, 2001 at 02:54:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 02:54:42PM +0200, Marek Michalkiewicz wrote:
> I was a bit surprised when I learned that _many_ motherboards
> support high speed (usually max 460800 bps) serial ports, but
> this fact is not advertised in any motherboard manuals!

This patch hard codes magic divisor values for a specific motherboard
into the serial driver.  The fact that the motherboard is using magic
divisor values is in incredible bad taste (unlike the motherboards
that simply use a faster clock frequency and so simply require
different base baud value), but the fact that the patch uncoditionally
recognizes these magic values and changes the behaviour for all UART's
unconditionally (not just for the motherbards that use this completely
broken design) is in very bad taste....

If you're going to do something like this, then it must be conditional
on a UART type that indicates that this is a broken UART that is
playing wierd shit divisor games.  Please don't do this
unconditionally, since then when the next broken motherboard design
uses another set of magic divisor numbers (which possibly might
overlap with VIA's broken magic divisor numbers), the result will be a
gigantic mess.....

						- Ted
