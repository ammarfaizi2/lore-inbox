Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312464AbSDELJ3>; Fri, 5 Apr 2002 06:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSDELJU>; Fri, 5 Apr 2002 06:09:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41875 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293076AbSDELJG>;
	Fri, 5 Apr 2002 06:09:06 -0500
Date: Fri, 05 Apr 2002 03:02:51 -0800 (PST)
Message-Id: <20020405.030251.28451401.davem@redhat.com>
To: stelian.pop@fr.alcove.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020405105509.GE16595@come.alcove-fr>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stelian Pop <stelian.pop@fr.alcove.com>
   Date: Fri, 5 Apr 2002 12:55:09 +0200
   
   > 	* client socket receives a TCP reset
   
   How is the client socket supposed to know it received a TCP reset
   (I am talking from the application point of view, not the kernel...) ?

You may find out by attempting to read data, or you may use the
extended IP error reporting Linux has.

But all of this is irrelevant.  When a server closes and says "send me
no more data", this implies that the server told the client it doesn't
want any more data.  If the client sends data, this is a gross fatal
error, so TCP resets in FIN_WAIT{1,2} states.

RFC 793 originally specified to queue the data, RFC 1122 is where
the current behavior is defined.


