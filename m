Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131272AbRCVWq3>; Thu, 22 Mar 2001 17:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132221AbRCVWqU>; Thu, 22 Mar 2001 17:46:20 -0500
Received: from pcp001515pcs.wireless.meeting.ietf.org ([135.222.67.247]:64775
	"EHLO think") by vger.kernel.org with ESMTP id <S131274AbRCVWqC>;
	Thu, 22 Mar 2001 17:46:02 -0500
Date: Thu, 22 Mar 2001 16:44:57 -0600
From: Theodore Tso <tytso@mit.edu>
To: Geir Thomassen <geirt@powertech.no>
Cc: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
Message-ID: <20010322164457.A4886@think>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Geir Thomassen <geirt@powertech.no>, linux-kernel@vger.kernel.org
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no> <20010322140852.A4110@think> <3ABA6167.309E6DB2@powertech.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ABA6167.309E6DB2@powertech.no>; from geirt@powertech.no on Thu, Mar 22, 2001 at 09:32:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 09:32:39PM +0100, Geir Thomassen wrote:
> 
> The serial port chip is 16550A, which has a built in fifo. Can this be
> the source of my problems ?

Well, if you set the uart to be 16450 using setserial, this will cause
Linux to avoid enabling the FIFO.  That will cause the loop to save
the 4 character times (which at 9600 bps is 4ms).  If your original
protocol is writing six characters, and then reads 2 characters in a
tight loop, that means a total cycle takes 8ms, and disabling the FIFO
will have significant savings assuming that all other causes of
latencies have been removed.  (The FIFO delay can cause a slowdown by
50%).

						- Ted
