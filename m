Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUEJVre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUEJVre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUEJVre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:47:34 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:32148 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261931AbUEJVrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:47:32 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 14:47:30 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andre Ben Hamou <andre@bluetheta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Multithread select() bug
In-Reply-To: <409FF38C.7080902@bluetheta.com>
Message-ID: <Pine.LNX.4.58.0405101446570.1156@bigblue.dev.mdolabs.com>
References: <409FF38C.7080902@bluetheta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Andre Ben Hamou wrote:

> void *threadFuntion (void *sockets) {
>      int socket = ((int *)sockets)[0];
>      struct timeval timeout = {tv_sec: 5, tv_usec: 0};
> 
>      // Allocate a file descriptor set with the passed socket
>      fd_set fds;
>      FD_ZERO (&fds);
>      FD_SET (socket, &fds);
> 
>      // Select to read / register exceptions on the FD set
>      select (socket + 1, &fds, NULL, &fds, &timeout);

Try:

	select (socket + 1, &fds, &fds, &fds, &timeout);
                                 ^^^^^


- Davide

