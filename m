Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSJ0Q0x>; Sun, 27 Oct 2002 11:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSJ0Q0x>; Sun, 27 Oct 2002 11:26:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2565 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262450AbSJ0Q0x>; Sun, 27 Oct 2002 11:26:53 -0500
Date: Sun, 27 Oct 2002 16:33:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/serial/core.c:1067 with 2.5.44
Message-ID: <20021027163307.A9553@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Romosan <romosan@sycorax.lbl.gov>,
	linux-kernel@vger.kernel.org
References: <87elabdf1q.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87elabdf1q.fsf@sycorax.lbl.gov>; from romosan@sycorax.lbl.gov on Sun, Oct 27, 2002 at 08:25:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 08:25:53AM -0800, Alex Romosan wrote:
> Oct 27 07:39:54 trinculo kernel: kernel BUG at drivers/serial/core.c:1067!

Someone called uart_set_termios without the BKL held, violating the locking
requirements.

Unfortunately:

1. You appear to be running a klogd that'll translate the addresses.
2. your ksymoops doesn't seem to know what modules are loaded.

This means we've lost the information telling us who called
uart_set_termios illegally.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

