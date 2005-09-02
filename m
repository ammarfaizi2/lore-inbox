Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVIBXl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVIBXl4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVIBXl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:41:56 -0400
Received: from smtpout.mac.com ([17.250.248.88]:27117 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751375AbVIBXlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:41:55 -0400
In-Reply-To: <4318DF26.5060707@zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902214231.GA10230@ccure.user-mode-linux.org> <dfahpa$an2$1@terminus.zytor.com> <9F74838E-651D-4952-BD7C-63B09D76F743@mac.com> <4318DF26.5060707@zytor.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <76E84FF2-A76E-4114-8E80-E07E6A497C7D@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Fri, 2 Sep 2005 19:41:44 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 2, 2005, at 19:24:22, H. Peter Anvin wrote:
> Kyle Moffett wrote:
>> My far-into-the-future ideal for this is to have a generic vDSO-type
>> library that is compiled into the kernel that provides a  
>> collection of
>> architecture-optimized routines available in both kernelspace and
>> userspace by mapping it into each process' address space.  Such a
>> library could effectively automatically provide correct and optimized
>> assembly routines for the currently booted CPU/arch/subarch/etc, so
>> that userspace tools could be compiled once and run on an entire
>> family of CPUs without modification.  On the other hand, for those
>> applications that need every last ounce of speed (Including parts of
>> the kernel), you could pass appropriate options to the compiler to
>> tell it to inline the assembly routines (alternative) for a single
>> CPU make/model.
>
> I don't see why this should be compiled into the kernel.

The kernel already needs those same optimized routines for its own
operation (EX: all the ASM alternative() statements).  Since userspace
wants some of those as well, it would make sense to share them between
kernel and userspace and reduce the number of libraries you would need
to optimize when adding a new arch.  I don't think that we should add
optimized assembly for things that _aren't_ needed in the kernel, but
it should share what code it does have.

A side benefit of the vDSO method is that you would be able to take a
standard distro install and have the kernel automatically select the
correct vDSO image at runtime, simultaneously optimizing itself and
chunks of userspace.

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


