Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSDEKvI>; Fri, 5 Apr 2002 05:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSDEKu6>; Fri, 5 Apr 2002 05:50:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31379 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312457AbSDEKuv>;
	Fri, 5 Apr 2002 05:50:51 -0500
Date: Fri, 05 Apr 2002 02:44:35 -0800 (PST)
Message-Id: <20020405.024435.88131177.davem@redhat.com>
To: stelian.pop@fr.alcove.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020405104733.GD16595@come.alcove-fr>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stelian Pop <stelian.pop@fr.alcove.com>
   Date: Fri, 5 Apr 2002 12:47:33 +0200

   On Fri, Apr 05, 2002 at 02:04:43AM -0800, David S. Miller wrote:
   
   > Your client does not do any write()'s after the shutdown call.
   > It simply exit(0)'s.
   
   You mean the 'server' ? Even if I add a sleep(600) between the 
   shutdown() call and the exit() call I get the same behaviour.

Oh I see now.  Here is what should happen:

	* server shutdown(ALL)
	* the write() should succeed on the client
	* client socket receives a TCP reset

If this isn't what is happening, send us a trace.
