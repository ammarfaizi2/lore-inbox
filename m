Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVBOX7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVBOX7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVBOX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:59:41 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:25524 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261956AbVBOX7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:59:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uJj+VyqLBDCL6fF2NGRY7OBb9NWVcXbJu+zDhApptipVYKO2LjOA97/4F/g9mPElmaMA9apl409zBaOKrXFUIo7vDAor7TgJga5X5kfuN4mhbvOBLAanRsvmIO8o1ROeUPWSAipa/o3tHUovQzy+Bbrk6TpJ+hS6Bu7qSJO07b0=
Message-ID: <a36005b5050215155946d5527e@mail.gmail.com>
Date: Tue, 15 Feb 2005 15:59:36 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Yves Crespin <crespin.quartz@wanadoo.fr>
Subject: Re: sigwait() and 2.6
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Yves Crespin <Crespin.Quartz@wanadoo.fr>
In-Reply-To: <4211F1F4.1070806@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050215031441.EFABE1DDFE@X31.nui.nul>
	 <1108471847.10281.3.camel@gaston> <4211F1F4.1070806@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 13:58:28 +0100, Yves Crespin
<crespin.quartz@wanadoo.fr> wrote:
>        ThreadUnblockSignal();
>        signo = WaitSignal();
>        ThreadBlockSignal();

You expect this to work?  Just read the POSIX spec or even the man
pages.  All signals sigwait() waits for must be blocked before the
call.  You deliberately do the opposite.  Swap the ThreadUnblockSignal
and ThreadBlockSignal lines and suddenly the program doesn't crash
anymore.
