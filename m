Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVJYPNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVJYPNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVJYPNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:13:45 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:20620 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932172AbVJYPNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:13:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ua9dVqiJtKfIEwhZiZUim2VICJaIOwOFyOjF1ECoOm1FoyhCqJbUVF/WAPXoY6FygEF0QfOiS52RlfwSauiCZvo1LbPBpZGvtX3xkH9uA1VmRWDwj5OP5kSIBiGGNvnj7hkLMq/ng7rzwivewqAJc6W9Thh3rz2mXUDJetNjC2w=
Subject: Re: 2.6.14-rc5-mm1
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       Andrew Vasquez <andrew.vasquez@qlogic.com>
In-Reply-To: <20051024141646.6265c0da.akpm@osdl.org>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <1130186927.6831.23.camel@localhost.localdomain>
	 <20051024141646.6265c0da.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 08:12:56 -0700
Message-Id: <1130253176.6831.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 14:16 -0700, Andrew Morton wrote:
..
> 
> qla2x00_probe_one() has called qla2x00_free_device() and
> qla2x00_free_device() has locked up in
> wait_for_completion(&ha->dpc_exited);
> 
> Presumably, ha->dpc_exited is not initialised yet.
> 
> The first `goto probe_failed' in qla2x00_probe_one() will cause
> qla2x00_free_device() to run wait_for_completion() against an uninitialised
> completion struct.  Because ha->dpc_pid will be >= 0.
> 
> This patch might fix the lockup, but if so, qla2x00_iospace_config()
> failed.  Please debug that a bit for us?

Yes. This patch helped. Due to power failures, my disk trays are
powered off. qla2x00_iospace_config() is failing and causing the
panic on -mm kernel. For odd reasons, older -mm kernels & mainline
kernels doesn't panic.

Thanks,
Badari



