Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbUKXRsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbUKXRsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbUKXRqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:46:39 -0500
Received: from zeus.kernel.org ([204.152.189.113]:19142 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262780AbUKXRnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:43:10 -0500
Date: Wed, 24 Nov 2004 13:07:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 7/51: Reboot handler hook.
Message-ID: <20041124130750.GA12730@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293507.5805.212.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101293507.5805.212.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#ifdef CONFIG_SOFTWARE_SUSPEND
> +#ifdef CONFIG_SOFTWARE_SUSPEND2
>  	case LINUX_REBOOT_CMD_SW_SUSPEND:
>  		{
> -			int ret = software_suspend();
> +			int ret = -EINVAL;
> +			if (!(test_suspend_state(SUSPEND_DISABLED))) {
> +				suspend_try_suspend();
> +				ret = 0;
> +			}
>  			unlock_kernel();

total crap.  Thbis patch breaks the existing swsusp and turns a clean
interface into a horrible one.  Just implement am

int software_suspend(void)
{
	if (test_suspend_state(SUSPEND_DISABLED))
		return -EINVAL;
	suspend_try_suspend();
	return 0;
}

in your code.
