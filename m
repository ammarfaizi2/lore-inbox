Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVBFURd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVBFURd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 15:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVBFURd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 15:17:33 -0500
Received: from coderock.org ([193.77.147.115]:6585 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261306AbVBFUR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 15:17:28 -0500
Date: Sun, 6 Feb 2005 21:17:21 +0100
From: Domen Puncer <domen@coderock.org>
To: Stephen Evanchik <evanchsa@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050206201721.GA14111@nd47.coderock.org>
References: <a71293c20502031443764fb4e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71293c20502031443764fb4e5@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a bit late, sorry. Haven't seen these mentioned in replies:


On 03/02/05 17:43 -0500, Stephen Evanchik wrote:
> +int tp_sens = TP_DEF_SENS;
> +module_param_named(sens, tp_sens, uint, 0);
> +MODULE_PARM_DESC(sens, "Sensitivity");

I don't see out-of-file usages... these could be static.

...
> +	static int name(char* page, char** start, off_t off, int count, int*
> eof, void* data) \
> +	{ \
> +		int len; \
> +		struct psmouse *psmouse = (struct psmouse *)data; \
> +		struct trackpoint_data *tp = (struct trackpoint_data*)psmouse->private; \

No need to cast (void *).

...
> +static int scroll_write_func(struct file *file, const char __user
> *buffer, unsigned long count, void *data)
> +{
> +	int len = count;
> +	unsigned char tmp[5];
> +	struct psmouse *psmouse = (struct psmouse *)data;
> +	struct trackpoint_data *tp = (struct trackpoint_data*)psmouse->private;
> +	if(count > sizeof(tmp) - 1)
> +		len = sizeof(tmp) - 1;

How about: len = min(count, sizeof(tmp) - 1);?

...
> +no_ext_dev:

Nitpick:
Some like ' ' before label (makes diff -pu patches more readable)



	Domen
