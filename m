Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTEFPTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbTEFPTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:19:42 -0400
Received: from [12.47.58.20] ([12.47.58.20]:47152 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263802AbTEFPTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:19:41 -0400
Date: Tue, 6 May 2003 08:33:58 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ebiederm@xmission.com
Subject: Re: 2.5.69-mm1
Message-Id: <20030506083358.348edb4d.akpm@digeo.com>
In-Reply-To: <1052231590.2166.141.camel@spc9.esa.lanl.gov>
References: <20030504231650.75881288.akpm@digeo.com>
	<1052231590.2166.141.camel@spc9.esa.lanl.gov>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 15:32:08.0283 (UTC) FILETIME=[A7A8BAB0:01C313E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> I have one machine for testing which is running X, and a kexec reboot
>  glitches the video system when initiated from runlevel 5.  Kexec works fine
>  from runlevel 3.

Yes, there are a lot of driver issues with kexec.  Device drivers will assume
that the hardware is in the state which the BIOS left behind.

In this case, the Linus device driver's shutdown functions are obviously not
leaving the card in a pristine state.  A lot of drivers _do_ do this
correctly.  But some don't.

It seems that kexec is really supposed to be invoked from run level 1.  ie:
you run all your system's shutdown scripts before switching.  If you'd done
that then you wouldn't have been running X and all would be well.

do-kexec.sh is for the very impatient ;)


