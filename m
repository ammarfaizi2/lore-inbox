Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274376AbRIYBh4>; Mon, 24 Sep 2001 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274372AbRIYBhr>; Mon, 24 Sep 2001 21:37:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3723 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274376AbRIYBhd>;
	Mon, 24 Sep 2001 21:37:33 -0400
Date: Mon, 24 Sep 2001 18:35:55 -0700 (PDT)
Message-Id: <20010924.183555.15266457.davem@redhat.com>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: read() called twice for /proc files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BAFDE0D.8A69A993@sun.com>
In-Reply-To: <3BAFDE0D.8A69A993@sun.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Hockin <thockin@sun.com>
   Date: Mon, 24 Sep 2001 18:29:49 -0700
   
   This results in the actual read taking twice as long.  Perhaps I am missing
   something...

EOF isn't known until you return the zero.  You can watch the loff_t
arg to the read operation to see if it is at the end, and if so just
avoid retouching the device or whatever and go straight to returning
0.

Franks a lot,
David S. Miller
davem@redhat.com
