Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262183AbSIZEf1>; Thu, 26 Sep 2002 00:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbSIZEf0>; Thu, 26 Sep 2002 00:35:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3715 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262183AbSIZEfZ>;
	Thu, 26 Sep 2002 00:35:25 -0400
Date: Wed, 25 Sep 2002 21:34:27 -0700 (PDT)
Message-Id: <20020925.213427.116352583.davem@redhat.com>
To: torvalds@transmeta.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] prepare_to_wait/finish_wait sleep/wakeup API
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209252133280.1451-100000@home.transmeta.com>
References: <20020925.212459.118951005.davem@redhat.com>
	<Pine.LNX.4.44.0209252133280.1451-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 25 Sep 2002 21:37:23 -0700 (PDT)
   
   On Wed, 25 Sep 2002, David S. Miller wrote:
   > For example, the ordering of the test and add/remove from
   > the wait queue is pretty important.
   
   The test and add yes. Remove no, since remove is always done after
   we know we're waking up.

Ok, so if the condition retest fails at wakeup (someone got to the
event before us), it's ok because we add ourselves back to the wait
queue first, mark ourselves as sleeping, _then_ retest.

Right?
