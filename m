Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268061AbTBWLkD>; Sun, 23 Feb 2003 06:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268123AbTBWLkD>; Sun, 23 Feb 2003 06:40:03 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:38916 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268061AbTBWLkC>; Sun, 23 Feb 2003 06:40:02 -0500
Date: Sun, 23 Feb 2003 11:50:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Toshiba keyboard workaroun
Message-ID: <20030223115012.A17127@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>, alan@redhat.com,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030218211940.GA1048@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030218211940.GA1048@elf.ucw.cz>; from pavel@ucw.cz on Tue, Feb 18, 2003 at 10:19:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 10:19:40PM +0100, Pavel Machek wrote:
> +        /*
> +         * Fix for Toshiba Satellites. Toshiba's like to repeat 
> +	 * "key down" event for A in combinations like shift-A.
> +	 * Thanx to Andrei Pitis <pink@roedu.net>.
> +         */
> +        static int prev_scancode = 0;
> +        static int stop_jiffies = 0;
> +
> +        /* new scancode, trigger delay */
> +        if (keycode != prev_scancode) 	       stop_jiffies = jiffies;
> +        else if (jiffies - stop_jiffies >= 10) stop_jiffies = 0;
> +        else {
> +	    printk( "Keyboard glitch detected, ignoring keypress\n" );
> +            return;
> +	}
> +        prev_scancode = keycode;
> +

That codingstyle is not acceptable.  Please reformat to match
Documentation/CodingStyle.  Also there are macros for jiffie overflow
handling you might want to use, see include/linux/jiffies.h

