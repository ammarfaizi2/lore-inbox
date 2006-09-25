Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWIYVeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWIYVeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWIYVeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:34:09 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:25285 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751455AbWIYVeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:34:08 -0400
Subject: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
	pmops->{prepare,enter,finish} support (aka "platform mode"))
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060925071338.GD9869@suse.de>
References: <20060925071338.GD9869@suse.de>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 07:34:03 +1000
Message-Id: <1159220043.12814.30.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-09-25 at 09:13 +0200, Stefan Seyfried wrote:
> +	case SNAPSHOT_PMOPS:
> +		switch (arg) {
> +
> +		case PMOPS_PREPARE:
> +			if (pm_ops->prepare) {
> +				error = pm_ops->prepare(PM_SUSPEND_DISK);
> +			}
> +			break;
> +
> +		case PMOPS_ENTER:
> +			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
> +			error = pm_ops->enter(PM_SUSPEND_DISK);
> +			break;
> +
> +		case PMOPS_FINISH:
> +			if (pm_ops && pm_ops->finish) {
> +				pm_ops->finish(PM_SUSPEND_DISK);
> +			}
> +			break;
> +
> +		default:
> +			printk(KERN_ERR "SNAPSHOT_PMOPS: invalid argument %ld\n", arg);
> +			error = -EINVAL;
> +
> +		}
> +		break;
> +
>  	default:
>  		error = -ENOTTY;

Guys! Why can't you see yet that all this uswsusp business is sheer
lunacy? All of the important code is done in the kernel, and must be
done in the kernel. Moving the little bit of high level logic that can
be done in userspace to userspace doesn't mean you're doing the
suspending in userspace.

If you have to use userspace for suspending, use it for the things that
don't matter, like the user interface, not the things that will break
suspending and resuming if they break.

</rant>

Nigel

