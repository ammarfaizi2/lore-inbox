Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWH3QfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWH3QfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWH3QfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:35:05 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:55937 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751135AbWH3QfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:35:03 -0400
Message-ID: <44F5BE36.10502@zabbo.net>
Date: Wed, 30 Aug 2006 09:35:02 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: yang.y.yi@gmail.com
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
References: <44F43F46.1070702@gmail.com> <44F48825.4050408@zabbo.net> <4c4443230608300651n34e8dbbdn8749c6874ce8791@mail.gmail.com>
In-Reply-To: <4c4443230608300651n34e8dbbdn8749c6874ce8791@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When I run ltp aio test case, for the operation OCB_CMD_FDSYNC and 
> IOCB_CMD_FSYNC, io_submit returns -1 and errno is EINVAL, perror's 
> output is "Invalid arguments", from the user's perspective, the 
> arguments are valid and the kernel also know it and progress the
> process to file operation of the filesystem actually, so I think
> ENOTSUP is more appropriate. Note ENOTSUP in the user space
> corresponds to EOPNOTSUPP in the kernel mode. For ENOTSUP, perror's
> output is "Function isn't implemented", obviously, it is a reasonable
> explanation about the execution error and not ambiguous.

This might have been a convincing argument when the interface was first
being written, but now we have to take into account that changing the
interface can break existing users.

That you prefer EOPNOTSUPP is not a compelling reason to break existing
setups, sorry.

- z
