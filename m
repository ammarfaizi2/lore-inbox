Return-Path: <linux-kernel-owner+w=401wt.eu-S1752050AbXAROsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbXAROsO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbXAROsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:48:13 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:56774 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbXAROsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:48:12 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VSEGIOn8uF/ppMhvsoBdo+jZ5gID9l0Ols/A2a5QmsZlvk5GVGvgP1GywUWgvWdxkdlbfWeEvZ9b85yaI+hoOSpuiZNizGP1qxEgt3KU0sCRoxQbjdOmpmX4zyVZ3VR3tY0tcnRMvox4TIunqqGVxpdYHyYqDtHpdrWanRQiKSk=
Message-ID: <9e0cf0bf0701180648r1dfa03bej5b8fb547c8d1d2e@mail.gmail.com>
Date: Thu, 18 Jan 2007 16:48:11 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Bernhard Walle" <bwalle@suse.de>, linux-kernel@vger.kernel.org,
       "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: [patch 03/26] Dynamic kernel command-line - arm
In-Reply-To: <20070118141359.GB31418@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070118125849.441998000@strauss.suse.de>
	 <20070118130028.719472000@strauss.suse.de>
	 <20070118141359.GB31418@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Jan 18, 2007 at 01:58:52PM +0100, Bernhard Walle wrote:
> > 2. Set command_line as __initdata.
>
> You can't.
>
> > -static char command_line[COMMAND_LINE_SIZE];
> > +static char __initdata command_line[COMMAND_LINE_SIZE];
>
> Uninitialised data is placed in the BSS.  Adding __initdata to BSS
> data causes grief.

Thanks for the reply!

There are many places in kernel that uses __initdata for uninitialized
variables.

For example:

./drivers/ide/ide.c:static int __initdata probe_ali14xx;
./drivers/ide/ide.c:static int __initdata probe_umc8672;
./drivers/ide/ide.c:static int __initdata probe_dtc2278;
./drivers/ide/ide.c:static int __initdata probe_ht6560b;
./drivers/ide/ide.c:static int __initdata probe_qd65xx;
static int __initdata is_chipset_set[MAX_HWIFS];

So all these current places are wrong?
If I initialize the data will it be OK.

Best Regards,
Alon Bar-Lev.
