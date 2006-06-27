Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWF0PMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWF0PMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWF0PMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:12:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37306 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161084AbWF0PMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:12:46 -0400
To: samuelkorpi@myway.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Calling kernel functions from kprobes/jprobes
References: <20060627080021.453306776E@mprdmxin.myway.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 27 Jun 2006 11:12:34 -0400
In-Reply-To: <20060627080021.453306776E@mprdmxin.myway.com>
Message-ID: <y0md5cur5st.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Samuel" <samuelkorpi@myway.com> writes:

> [...]  I am using kprobes/jprobes to try and understand how IP
> options are handled in the kernel. From one of these probes I want
> to call another function inside the kernel, namely
> ip_options_get_from_user. [...]

Other than symbol exporting issues, you may encounter another problem
that we have encountered in systemtap (which is also a kprobes
client).  That is that the context where the kprobe was placed may be
such that calling most ordinary kernel routines is unsafe.  In
particular, ip_options_get_from_user may sleep, which may or may not
be legal from the context of the kprobe.  (In systemtap probes, we
don't permit anything to block/sleep/schedule, so instead suffer
absent-page errors.)

- FChE
