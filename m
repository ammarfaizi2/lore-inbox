Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTEYVyA (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTEYVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 17:54:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8078 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263783AbTEYVx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 17:53:59 -0400
Date: Sun, 25 May 2003 23:07:09 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: netlink init order
Message-ID: <20030525220709.GJ6270@parcelfarce.linux.theplanet.co.uk>
References: <3ED12727.1080907@redhat.com> <20030525213040.GH6270@parcelfarce.linux.theplanet.co.uk> <20030525215150.GI6270@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525215150.GI6270@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, is there any reason why init_netlink_dev() is not a module_init()?

We have
int init_module(void)
{
        printk(KERN_INFO "Network Kernel/User communications module 0.04\n");
        return init_netlink();
}

void cleanup_module(void)
{
        int i;

        for (i = 0; i < ARRAY_SIZE(entries); i++)
                devfs_remove("netlink/%s", entries[i].name);
        for (i = 0; i < 16; i++)
                devfs_remove("netlink/tap%d", i);
        devfs_remove("netlink");
        unregister_chrdev(NETLINK_MAJOR, "netlink");
}

in netlink_dev.c and

#ifdef CONFIG_NETLINK_DEV
        init_netlink();
#endif
        return 0;
}

in the end of netlink_proto_init(), which is core_initcall.
