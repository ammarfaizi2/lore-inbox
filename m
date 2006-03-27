Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWC0Qem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWC0Qem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWC0Qem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:34:42 -0500
Received: from wproxy.gmail.com ([64.233.184.236]:8222 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751045AbWC0Qel convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:34:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KNLU8OGi+isJ3YmNg/BCe8kFZY4Rjy7wid00Pu1PyH0smtjfnoEvLvGVtkyoKuTDqBmLc1QC40EGJ5dOUu1O7XZrGQacDB+Jrg5CGe1Ny+31wZl9Xc7d45UncsXgHBMN/+q2KsD6j6GTnHN2g5eNy+TtYQswiijJx1O+1GABDRg=
Message-ID: <d120d5000603270834j79e707ffu760eba3062531b64@mail.gmail.com>
Date: Mon, 27 Mar 2006 11:34:39 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Stas Sergeev" <stsp@aknet.ru>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Cc: 7eggert@gmx.de, "Linux kernel" <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
In-Reply-To: <44266472.5080309@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it>
	 <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it>
	 <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz>
	 <44266472.5080309@aknet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/06, Stas Sergeev <stsp@aknet.ru> wrote:
>
> I think I'd better try to code up the grabbing capability in
> the input layer, since Dmitry didn't seem to object to that.
>

I was pondering over implications of "grabbing" events over the
weekend and I am not entirely happy with it either. The problem with
grabbing is that your driver does not have any knowledge of how the
events would be processed if left untouched. Right now you assume that
all bells are handled by pcspkr but we could really have alternative
bell implementations. For example we could have "visual" bell that
could flash framebuffer or a bell that is routed through ALSA, etc,
etc. All these alternative bells would not disrupt operation of your
snd_pcsp module but it still would disable the bell because it does
not know better.

--
Dmitry
