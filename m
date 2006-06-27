Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWF0Nrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWF0Nrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWF0Nrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:47:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11236 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932278AbWF0Nrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:47:52 -0400
Date: Tue, 27 Jun 2006 15:45:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 15/20] [Suspend2] Attempt to freeze processes.
Message-ID: <20060627134514.GC3019@elf.ucw.cz>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net> <20060626223537.4050.72340.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626223537.4050.72340.stgit@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Call the freezer code to get processes frozen, and abort suspending if that
> fails. May be called multiple times as we thaw kernel space (only) if we
> need to free memory to meet constraints.

Current code seems to free memory without need to thaw/re-freeze
kernel threads. Have you found bugs in that, or is this unneccessary?

> +static int attempt_to_freeze(void)
> +{
> +	int result;
> +	
> +	/* Stop processes before checking again */
> +	thaw_processes(FREEZER_ALL_THREADS);
> +	suspend_prepare_status(CLEAR_BAR, "Freezing processes");
> +	result = freeze_processes();
> +
> +	if (result) {
> +		set_result_state(SUSPEND_ABORTED);
> +		set_result_state(SUSPEND_FREEZING_FAILED);
> +	} else
> +		are_frozen = 1;
> +
> +	return result;
> +}
> +


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
