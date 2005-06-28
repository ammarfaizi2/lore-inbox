Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVF1Oyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVF1Oyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVF1Oyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:54:44 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:4878 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262016AbVF1Oyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:54:33 -0400
Message-ID: <42C16691.3090205@shadowconnect.com>
Date: Tue, 28 Jun 2005 17:02:41 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: sysfs abuse in recent i2o changes
References: <20050628112102.GA1111@lst.de>
In-Reply-To: <20050628112102.GA1111@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Christoph Hellwig wrote:
> drivers/message/i2o/config-osm.c has a function sysfs_create_fops_file,
> which creates a sysfs file with supplied file_operations.  This is
> pretty much against the sysfs design which only wants simple attributes,
> ascsii or for corner cases binary.

I know, but i hopefully also have a good reason to do so... First, the 
attributes provided through these functions are for accessing the 
firmware... The controller has a little limitation, it could only handle 
64 blocks, but sysfs only have 4k...

Now there are two options:

1) when writing: read a 64k block, merge it with the 4k block and write 
it back, when reading: read a 64k block and only return the needed 4k block.

2) extend the sysfs attribute to allow 64k blocks

IMHO the first is not a very good solution, because for a 64k block it 
has to be written 16 times...

Of course if someone finds a better solution i would be glad to hear 
about it...

Thank you very much.


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
