Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVGSHRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVGSHRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 03:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVGSHRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 03:17:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37294 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261936AbVGSHRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 03:17:35 -0400
Date: Tue, 19 Jul 2005 00:17:29 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Fw: Oops in hidinput_hid_event
Message-Id: <20050719001729.36d35238.zaitcev@redhat.com>
In-Reply-To: <9a874849050718183175bc08d4@mail.gmail.com>
References: <20050718141637.074c6f70.zaitcev@redhat.com>
	<9a874849050718183175bc08d4@mail.gmail.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2005 03:31:12 +0200, Jesper Juhl <jesper.juhl@gmail.com> wrote:

> >  void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
> >  {
> > -       struct input_dev *input = &field->hidinput->input;
> > +       struct input_dev *input;
> >         int *quirks = &hid->quirks;
> > 
> > -       if (!input)
> > +       if (!field->hidinput)
> 
> How about
>              if (!field || !field->hdinput)
> instead?
> 
> >                 return;
> > +       input = &field->hidinput->input;

It would be more reliable, certainly. However, this is likely not what
Vojtech has intended. I do not understand how this code functions,
and I would be ashamed just adding NULL checks all over the place.
Also, the original oops happens after a certain field was accessed,
not at an argument. It's not quite clear to me what happened, because
of optimizations, but I suspect this may be it.

-- Pete
