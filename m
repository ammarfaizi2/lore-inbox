Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292228AbSBTTXh>; Wed, 20 Feb 2002 14:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292223AbSBTTXc>; Wed, 20 Feb 2002 14:23:32 -0500
Received: from cheetah.monarch.net ([24.244.0.4]:40461 "HELO
	cheetah.monarch.net") by vger.kernel.org with SMTP
	id <S292150AbSBTTXV>; Wed, 20 Feb 2002 14:23:21 -0500
Date: Wed, 20 Feb 2002 12:21:16 -0700
From: "Peter J. Braam" <braam@clusterfs.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, phil@off.net
Subject: Re: tmpfs, NFS, file handles
Message-ID: <20020220122116.C28913@lustre.cfs>
In-Reply-To: <20020220094649.X25738@lustre.cfs> <3C73D548.648C5D64@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C73D548.648C5D64@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Feb 20, 2002 at 11:56:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> "Peter J. Braam" wrote:
...
> > Is there a suggested solution for fh_to_dentry and dentry_to_fh for
> > tmpfs?
> > 
> > An "iget" based solution might work but at present tmpfs inodes are
> > not hashed.
On Wed, Feb 20, 2002 at 11:56:40AM -0500, Jeff Garzik wrote:
...
> I talked to neil brown about NFS and ramfs... he mentioned using
> iunique()


So do I understand that hashing tmpfs inodes is perhaps the way to go?

Would the following also work? 

 - have a 32 bit counter: set inode->i_ino to count++
 - up the generation number each time the counter warps. 

Between boot cycles NFS could still get confused, that might be helped
by setting the initial generation to the system time. 

Thoughts anyone? 

- Peter -
