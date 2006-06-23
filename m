Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932912AbWFWHbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbWFWHbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932913AbWFWHbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:31:31 -0400
Received: from gw.openss7.com ([142.179.199.224]:10961 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932912AbWFWHbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:31:31 -0400
Date: Fri, 23 Jun 2006 01:31:28 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: danial_thom@yahoo.com,
       =?iso-8859-1?Q?=22P=E1draig=22Brady?= <P@draigBrady.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Dropping Packets in 2.6.17
Message-ID: <20060623013128.A32391@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Robert Hancock <hancockr@shaw.ca>, danial_thom@yahoo.com,
	=?iso-8859-1?Q?=22P=E1draig=22Brady?= <P@draigBrady.com>,
	linux-kernel@vger.kernel.org
References: <fa.zPWsMAz4l0d9j5Voaw6Pdkcf//M@ifi.uio.no> <fa.Ze3oSnDYEMz3/ITqeLQ2m0GF5wk@ifi.uio.no> <449B4038.3040101@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <449B4038.3040101@shaw.ca>; from hancockr@shaw.ca on Thu, Jun 22, 2006 at 07:13:28PM -0600
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,

On Thu, 22 Jun 2006, Robert Hancock wrote:
> 
> If you want to give more priority to processing network packets at the 
> expense of user processes then you likely need to increase the priority 
> of the ksoftirqd thread(s). These compete for CPU time like any other 
> processes.
> 

I don't think that's a fair statement:

 - "any other process" does not execute when returning from an interrupt
    as do softirq threads

 - "any other process" does not execute upon local_bh_enable().

 - "any other process" is blockable (which at softirq is a big BUG()).

Under moderate to heavy load, throttling (or disabling) hard interrupts
effectively reduces the priority of ksoftirqd threads (they have less
opportunity to run because interrupts are returning less often).
