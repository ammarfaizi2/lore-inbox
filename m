Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132177AbRCVUKR>; Thu, 22 Mar 2001 15:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132176AbRCVUKH>; Thu, 22 Mar 2001 15:10:07 -0500
Received: from pcp001515pcs.wireless.meeting.ietf.org ([135.222.67.247]:48644
	"EHLO think") by vger.kernel.org with ESMTP id <S132172AbRCVUJ5>;
	Thu, 22 Mar 2001 15:09:57 -0500
Date: Thu, 22 Mar 2001 14:08:52 -0600
From: Theodore Tso <tytso@mit.edu>
To: Geir Thomassen <geirt@powertech.no>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: Serial port latency
Message-ID: <20010322140852.A4110@think>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Geir Thomassen <geirt@powertech.no>, linux-kernel@vger.kernel.org
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no>; from geirt@powertech.no on Thu, Mar 22, 2001 at 07:21:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 07:21:28PM +0100, Geir Thomassen wrote:
> My program controls a device (a programmer for microcontrollers) via the
> serial port. The program sits in a tight loop, writing a few (typical 6)
> bytes to the port, and waits for a few (typ. two) bytes to be returned from
> the programmer. 

Check out the man page for the "low_latency" configuration parameter
in the setserial man page.  This will cause the serial driver to burn
a small amount of additional CPU overhead when processing characters,
but it will lower the time between when characters arrive at the
RS-232 port and when they are made available to the user program.  The
preferable solution is to use a intelligent windowing protocol that
isn't heavily latency dependent (all modern protocols, such as kermit,
zmodem, tcp/ip, etc. do this).  But if you can't, using setserial to
set the "low_latency" flag will allow you to work around a dumb
communications protocol.

						- Ted
