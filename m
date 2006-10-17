Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWJQVwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWJQVwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWJQVwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:52:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750954AbWJQVwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:52:06 -0400
Date: Tue, 17 Oct 2006 14:51:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>
Subject: Re: [PATCH] add process_session() helper routine
Message-Id: <20061017145142.518e4046.akpm@osdl.org>
In-Reply-To: <45349658.9060805@fr.ibm.com>
References: <45349658.9060805@fr.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 10:37:44 +0200
Cedric Le Goater <clg@fr.ibm.com> wrote:

> This patch replaces occurences of task->signal->session by a new 
> process_session() helper routine. 
> 
> It will be useful for pid namespaces to abstract the session pid
> number.

hm.

> +static inline pid_t process_session(struct task_struct *tsk)
> +{
> +	return tsk->signal->session;
> +}
> +

We should rename signal_struct.session to something else
(session_dont_use_me_directly) so that any code which accidentally fails to
use the wrapper will reliably fail to build.

That means that we'll also need a helper function to set this field.
