Return-Path: <linux-kernel-owner+w=401wt.eu-S1752661AbWLSGiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbWLSGiu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbWLSGiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:38:50 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:42462 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbWLSGit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:38:49 -0500
Date: Tue, 19 Dec 2006 09:38:38 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [take28-resend_2->0 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061219063838.GA23757@2ka.mipt.ru>
References: <11663636322861@2ka.mipt.ru> <458760C9.7080504@redhat.com> <20061219045130.GA28980@2ka.mipt.ru> <458784EE.7080303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <458784EE.7080303@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 19 Dec 2006 09:38:39 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 10:21:34PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >I've uploaded the latest changes to the homepage.
> 
> Thanks.  But could you now update the patch so that it can be compiled 
> with the current upstream kernel?  At least <linux/kevent.h> has 
> problems because of file->st accesses.

file->st is only defined for poll/select events, if it is not specified
at compile time, functions in linux/kevent.h becomes void:

#ifdef CONFIG_KEVENT_POLL
static inline void kevent_init_file(struct file *file)
{
	kevent_storage_init(file, &file->st);
}

static inline void kevent_cleanup_file(struct file *file)
{
	kevent_storage_fini(&file->st);
}
#else
static inline void kevent_init_file(struct file *file) {}
static inline void kevent_cleanup_file(struct file *file) {}
#endif

What error messages do you see and what are kevent related config
changes?

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
