Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBTWFl>; Tue, 20 Feb 2001 17:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129135AbRBTWFc>; Tue, 20 Feb 2001 17:05:32 -0500
Received: from [199.239.160.155] ([199.239.160.155]:8709 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129066AbRBTWFQ>; Tue, 20 Feb 2001 17:05:16 -0500
Date: Tue, 20 Feb 2001 14:05:15 -0800
From: Robert Read <rread@datarithm.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel/printk.c: increasing the buffer size to capture devfsd debug messages.
Message-ID: <20010220140515.C4106@tenchi.datarithm.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A92A99E.2F255CB3@yk.rim.or.jp> <20010220111542.A4106@tenchi.datarithm.net> <3A92C76C.6519DF1A@cypress.com> <20010220121727.B4106@tenchi.datarithm.net> <3A92D930.6F11B505@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A92D930.6F11B505@cypress.com>; from ted@cypress.com on Tue, Feb 20, 2001 at 02:53:04PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 02:53:04PM -0600, Thomas Dodd wrote:
> Robert Read wrote:
> 
> Why not just make the config option in Kbytes.
> and do:
> 
> #define LOG_BUF_LEN (CONFIG_PRINTK_BUF_LEN * 1024)
> 

This is good idea, but I believe LOG_BUF_LEN needs to be a power of
2.  A bitmask is used in several places to wrap around the end of the
ring buffer.  For example

#define LOG_BUF_MASK	 (LOG_BUF_LEN-1)

printk() {
  ....
  log_buf[(log_start+log_size) & LOG_BUF_MASK] = *p;
}


I think LOG_BUF_LEN could be defined to round up (or down) at compile
time, but my post-lunch-sleepy brain can't think of the trick to do
it.

robert
