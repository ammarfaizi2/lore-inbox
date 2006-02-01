Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbWBANCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWBANCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBANCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:02:00 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:14739 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932422AbWBANB7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:01:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wb0TmpoO7+5nd6NIkzpLYayoLI3ZtKjMrvFkV5f5y14KQo5kkpEoAOqX0YJ25oaDyqpodz9ahMYsee1CMt7oU6Y1g7jtL6aSmjts6F0g83i9PlVUOnsWW/9JZZzmsqrSQBb5JI5V2Mi/Lch6GRFBVQJWh3Qg+n5aEwWz14m3KOA=
Message-ID: <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
Date: Wed, 1 Feb 2006 15:01:57 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602012245.06328.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060201113711.6320.42205.stgit@localhost.localdomain>
	 <84144f020602010432p51ff7a9cq1dd6654bd04f36a4@mail.gmail.com>
	 <200602012245.06328.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> --- /dev/null
> +++ b/kernel/power/modules.h

> +struct module_header {

[snip]

> +extern int num_modules, num_writers;

[snip]

> +extern struct suspend_module_ops *active_writer;

[snip]

> +extern void prepare_console_modules(void);
> +extern void cleanup_console_modules(void);

[snip, snip]

> +extern unsigned long header_storage_for_modules(void);
> +extern unsigned long memory_for_modules(void);
> +
> +extern int print_module_debug_info(char *buffer, int buffer_size);

Suspend prefix for the names of all of the above please? They're
confusing with kernel/module.c now.

> +extern int suspend_register_module(struct suspend_module_ops *module);
> +extern void suspend_unregister_module(struct suspend_module_ops *module);
> +
> +extern int suspend2_initialise_modules(int starting_cycle);
> +extern void suspend2_cleanup_modules(int finishing_cycle);
> +
> +int suspend2_get_modules(void);
> +void suspend2_put_modules(void);

I think we can call these suspend_{get|set}_modules instead i.e.
without the extra '2'.

> +
> +static inline void suspend_initialise_module_lists(void) {
> +       INIT_LIST_HEAD(&suspend_filters);
> +       INIT_LIST_HEAD(&suspend_writers);
> +       INIT_LIST_HEAD(&suspend_modules);
> +}

I couldn't find a user for this. I would imagine there's only one,
though, and this should be inlined there?

                        Pekka
