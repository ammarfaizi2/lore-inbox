Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbTDOIno (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbTDOIno (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:43:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1801 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264402AbTDOInn (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 04:43:43 -0400
Date: Tue, 15 Apr 2003 09:55:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: george anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix jiffies_to_time[spec | val] and converse to use actual jiffies increment rather than 1/HZ
Message-ID: <20030415095528.B32468@flint.arm.linux.org.uk>
Mail-Followup-To: george anzinger <george@mvista.com>,
	Andrew Morton <akpm@zip.com.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3E9BC49E.7010903@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9BC49E.7010903@mvista.com>; from george@mvista.com on Tue, Apr 15, 2003 at 01:36:46AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 01:36:46AM -0700, george anzinger wrote:
> In the current system (2.5.67) time_spec to jiffies, time_val to 
> jiffies and the converse (jiffies to time_val and jiffies to 
> time_spec) all use 1/HZ as the measure of a jiffie.  Because of the 
> inability of the PIT to actually generate an accurate 1/HZ interrupt, 
> the wall clock is updated with a more accurate value (999848 
> nanoseconds per jiffie for HZ = 1000).

There's an increasing amount of 64-bit math appearing here, which gcc
has been historically bad with.  Is there any chance that all this
extra complexity can vanish for architectures which do not have this
problem?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

