Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285206AbRLRVpN>; Tue, 18 Dec 2001 16:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLRVnr>; Tue, 18 Dec 2001 16:43:47 -0500
Received: from [217.9.226.246] ([217.9.226.246]:65408 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S285210AbRLRVmU>; Tue, 18 Dec 2001 16:42:20 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <Pine.LNX.4.21.0112181757460.4821-100000@freak.distro.conectiva>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.21.0112181757460.4821-100000@freak.distro.conectiva>
Date: 18 Dec 2001 23:26:54 +0200
Message-ID: <876674i5i9.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Marcelo" == Marcelo Tosatti <marcelo@conectiva.com.br> writes:

Marcelo> Momchil, 

Marcelo> Your fix does not look right. We _have_ to sync pages at
Marcelo> sync_page_buffers(), we cannot "ignore" them.

>> Sure, we don't ignore them, we just don't _wait_ for them, because
>> maybe _we_ are the one to write them.  

Marcelo> What if we are not ? 

Hmm, looks like we pray to find another immediately usable page, to
finish _this_ request first, and then we will ``loop_get_bh'' the
buffer we just avoided waiting on and sync it.  

Hmm, _maybe_ it is a good idea buffers submitted for IO by the
loopback threads to themselves go _in front_ of the loopback queue ?

Regards,
-velco

