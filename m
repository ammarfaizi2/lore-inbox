Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSLBQST>; Mon, 2 Dec 2002 11:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSLBQST>; Mon, 2 Dec 2002 11:18:19 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:65168 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP
	id <S264643AbSLBQSR> convert rfc822-to-8bit; Mon, 2 Dec 2002 11:18:17 -0500
Date: Mon,  2 Dec 2002 14:25:44 -0200
Message-Id: <H6I2YW$293289E6C31F693B4F51121D01793170@terra.com.br>
Subject: =?iso-8859-1?Q?Re:Linux_2.4.18_8139too.c_driver_fix_for_mii-tool?=
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "=?iso-8859-1?Q?Felipe_W_Damasio?=" <felipewd@terra.com.br>
To: "=?iso-8859-1?Q?dash?=" <dash@xdr.com>
Cc: "=?iso-8859-1?Q?linux-kernel?=" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 3.2 R28 (B53)
X-type: 0
X-SenderIP: 200.163.191.105
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Cabeçalho inicial  -----------

De: linux-kernel-owner@vger.kernel.org
Para: linux-kernel@vger.kernel.org
Cópia: 
Data: Mon, 02 Dec 2002 08:11:52 -0800
Assunto: Linux 2.4.18 8139too.c driver fix for mii-tool

> The fix is to change the masking done in the top of netdev_ioctl:
> 	if (cmd != SIOCETHTOOL) {
> 		/* With SIOCETHTOOL, this would corrupt the pointer.  */
> 		data->phy_id &= 0x3f; // was 0x1f (DA) 20021202
> 		data->reg_num &= 0x1f;
> 	}

  In 2.4.20, the non-ethtool ioctls on 8139too (and 8139cp, for that
matter) are handled by mii.c::generic_mii_ioctl, which already have
this fix (in a more generic way):

mii_data->phy_id &= mii_if->phy_id_mask;
mii_data->reg_num &= mii_if->reg_num_mask; 

  You can check 

http://www.kernel.org/diff/diffview.cgi?css=%2Fdiff%2Fdiff.css;file=%2Fpub%2Flinux%2Fkernel%2Fv2.4%2Fpatch-2.4.20.gz;z=1765

  For more details.

  Kind Regards,

Felipe

