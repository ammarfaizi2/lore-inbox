Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVHRSX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVHRSX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVHRSX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:23:57 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:6108 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932380AbVHRSX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:23:56 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Environment variables inside the kernel?
References: <4fec73ca050818084467f04c31@mail.gmail.com>
	<m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
From: "Linh Dang" <linhd@nortel.com>
Organization: Null
Date: Thu, 18 Aug 2005 14:23:51 -0400
In-Reply-To: <m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local> (Douglas
 McNaught's message of "Thu, 18 Aug 2005 12:37:14 -0400")
Message-ID: <wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas McNaught <doug@mcnaught.org> wrote:

>
> If someone is insisting you use environment varaiables in kernel
> code, challenge them to show you where they are implemented in the
> kernel.  :)
>
> -Doug

They're in current process's vm. You just have to parse it yourself.

something along the (untested) lines:

        struct mm_struct *mm = current ? get_task_mm(current) : NULL;

        if (mm) {
                unsigned env_len = mm->env_end - mm->env_start;
                char* env = kmalloc(env_len, GFP_KERNEL);
                access_process_vm(current, mm->env_start, env,
                                           env_len, 0);

                /* env is now a big buffer containing null-terminated
                   strings representing evironment variables */

                mmput(mm);
        }

-- 
Linh Dang
