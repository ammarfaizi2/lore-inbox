Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVFCUuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVFCUuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 16:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFCUuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 16:50:32 -0400
Received: from god.demon.nl ([83.160.164.11]:34829 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S261359AbVFCUuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 16:50:20 -0400
Date: Fri, 3 Jun 2005 22:50:14 +0200
From: Henk <Henk.Vergonet@gmail.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
Message-ID: <20050603205014.GB3360@god.dyndns.org>
References: <20050531220738.GA21775@god.dyndns.org> <429DAB07.1050900@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429DAB07.1050900@anagramm.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 02:33:11PM +0200, Clemens Koller wrote:
> Hello, Henk!
> 
> >1 - Notation
> >
> >Make things potential interoperable, your character sets will be
> >portable to other LCD devices.
> >
> >   +-a-+
> >   f   b
> >   +-g-+   => encodes to =>  MSb  76543210 LSb
> >   e   c                           gfedcba
> >   +-d-+                     bit7 is reserved.
>           (x)
> 
> Bit7 is propably useful for the decimal point (x)?
> Well, that's how I used it some time ago.
>
Hi Clemens,

I think it could. However for conveniance I implemented it as a
seperate addressable entity.

For userspace I want things to be simple, just a simple echo should be
sufficient to manipulate the LCD:

For example:

   echo -n "3 A  1.0 0 0" > /sys/.../line1

in order to set the lcd. In order to read back the contents of the lcd:

  cat  /sys/.../line1
  8.8.8.8.8.8.8.8.888  <= format string, see below
  3 A   1.0 0 0        <= contents


When the dot is encoded in the digit you would lose a digit when a 
dot is printed. In a two segment display with dots "1.0" can not be 
printed.

I don't want kernelcode trying to decide if it should collapse "1." in
a single digit or not. These implicit functional rules are always a
pain in the ass when not implmented at the right level. And don't 
belong in the kernel.

Best regards,
Henk


/* Format string description:
 *
 * From a user space perspective the world is seperated in "digits" and "icons".
 * A digit can have a character set, an icon can either be ON or OFF.
 *
 * Format specifier
 *   '8' :  Generic 7 segment digits with individual addressable segments
 *
 *   Reduced capabillity 7 segm digits, when segments are hard wired together.
 *   '1' : 2 segments digit only able to produce 1.
 *   'e' : Most significant day of the month digit,
 *         able to produce at least 1 2 3.
 *   'M' : Most significant minute digit,
 *         able to produce at least 0 1 2 3 4 5.
 *
 *   Icons or pictograms:
 *   '.'  : For example like AM, PM, SU, a 'dot' .. or other single segment
 *          elements.
 */

