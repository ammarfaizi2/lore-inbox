Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130121AbQKPMoO>; Thu, 16 Nov 2000 07:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130145AbQKPMoE>; Thu, 16 Nov 2000 07:44:04 -0500
Received: from ns.caldera.de ([212.34.180.1]:19466 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130121AbQKPMnx>;
	Thu, 16 Nov 2000 07:43:53 -0500
Date: Thu, 16 Nov 2000 13:13:37 +0100
Message-Id: <200011161213.NAA27334@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: davem@redhat.com ("David S. Miller")
Cc: willy@meta-x.org, linux-kernel@vger.kernel.org, wtarreau@yahoo.fr
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200011160845.AAA10212@pizda.ninka.net>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200011160845.AAA10212@pizda.ninka.net> you wrote:

> I never ported it to the new PCI interfaces strictly because when
> combined with SBUS it makes the driver initialization look really
> sloppy.

BTW, what do you think of a new PCI style probing for SBUS?
When I hacked on a small sbus driver, I thought it might be a good idea
to have tables like the new PCI interface for all busses.

The interface for SBUS would be:

struct sbus_device_id {
	char *		promname;
	unsigned long	driver_data;
};

struct sbus_driver {
	struct list_head	node;
	char *			name;
	struct sbus_device_id *	id_table;

	int (* probe)(struct sbus_dev * dev, const struct sbus_device_id * id);
	void (* remove)(struct sbus_dev * dev);
};

Would you accept such a change for 2.5?

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
