Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbREVH6j>; Tue, 22 May 2001 03:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbREVH6U>; Tue, 22 May 2001 03:58:20 -0400
Received: from zeus.kernel.org ([209.10.41.242]:62850 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262587AbREVH6N>;
	Tue, 22 May 2001 03:58:13 -0400
X-From-Line: nobody Tue May 22 08:50:17 2001
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: tmpfs + sendfile bug ?
In-Reply-To: <XFMail.20010521183553.petchema@concept-micro.com>
	<m3bsomwsgs.fsf@linux.local>
	<200105212201.PAA17247@penguin.transmeta.com>
Organisation: SAP LinuxLab
Date: 22 May 2001 08:50:11 +0200
In-Reply-To: <200105212201.PAA17247@penguin.transmeta.com>
Message-ID: <m3ofslvpwc.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 21 May 2001, Linus Torvalds wrote:
> In article <m3bsomwsgs.fsf@linux.local>, Christoph Rohland
> <cr@sap.com> wrote:
>>
>>tmpfs does not provide the necessary functions for sendfile and lo:
>>readpage, prepare_write and commitwrite.
>>
>>And I do not see a way how to provide readpage in tmpfs :-(
> 
> Why not just do it the same way ramfs does?
> 
> If you don't have any backing store, you know that the page is
> empty. If you _do_ have backing store, a readpage() won't be
> called. Ergo:

AFAIU readpage is fine as long as there is no backing store. But if
the page is in the swap cache, the lookup of the page in the page
cache will fail; generic_file_read, loop, sendfile will allocate a
page and call readpage with that. Now readpage has to copy the swap
cache page over to this page :-(

IMHO Copying on swapin is really not worth the additional
functionality.

Did I miss something?

		Christoph


