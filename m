Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRIQQLv>; Mon, 17 Sep 2001 12:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbRIQQLl>; Mon, 17 Sep 2001 12:11:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36945 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271777AbRIQQLa>; Mon, 17 Sep 2001 12:11:30 -0400
To: "Rob Fuller" <rfuller@nsisoftware.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907BB98@xchgind02.nsisw.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Sep 2001 10:03:06 -0600
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907BB98@xchgind02.nsisw.com>
Message-ID: <m166ahst39.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rob Fuller" <rfuller@nsisoftware.com> writes:

> One argument for reverse mappings is distributed shared memory or
> distributed file systems and their interaction with memory mapped
> files.  For example, a distributed file system may need to invalidate a specific
> page of a file that may be mapped multiple times on a node.

To reduce the time for an invalidate is indeed a good argument for
reverse maps.  However this is generally the uncommon case, and it is
fine to leave this kinds of things on the slow path.  From struct page 
we currently go to struct address_space to lists of struct vm_area
which works but is just a little slower (but generally cheaper) than
having a reverse map.

Since Rik was not seeing the invalidate or the unmap case as the
bottleneck this reverse mappings are not needed simply something
with a similiar effect on the VM.  

In linux we have avoided reverse maps (unlike the BSD's) which tends
to make the common case fast at the expense of making it more
difficult to handle times when the VM system is under extreme load and
we are swapping etc.

Eric

