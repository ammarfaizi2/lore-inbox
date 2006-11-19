Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933415AbWKSVw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415AbWKSVw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933400AbWKSVw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:52:56 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:58541 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S933397AbWKSVwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:52:55 -0500
Date: Sun, 19 Nov 2006 22:46:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jay Cliburn <jacliburn@bellsouth.net>
cc: jeff@garzik.org, shemminger@osdl.org, romieu@fr.zoreil.com,
       csnook@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
In-Reply-To: <20061119203050.GD29736@osprey.hogchain.net>
Message-ID: <Pine.LNX.4.61.0611192237170.6324@yvahk01.tjqt.qr>
References: <20061119203050.GD29736@osprey.hogchain.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>+char at_driver_name[] = "atl1";
>+static const char at_driver_string[] = "Attansic(R) L1 Ethernet Network Driver";
>+const char at_driver_version[] = DRV_VERSION;
>+static const char at_copyright[] =
>+    "Copyright(c) 2005-2006 Attansic Corporation.";
>+

>+extern s32 at_read_mac_addr(struct at_hw *hw);
>+extern s32 at_init_hw(struct at_hw *hw);
>+extern s32 at_get_speed_and_duplex(struct at_hw *hw, u16 * speed, u16 * duplex);
>+extern s32 at_set_speed_and_duplex(struct at_hw *hw, u16 speed, u16 duplex);
>+extern u32 at_auto_get_fc(struct at_adapter *adapter, u16 duplex);
>+extern u32 at_hash_mc_addr(struct at_hw *hw, u8 * mc_addr);
>+extern void at_hash_set(struct at_hw *hw, u32 hash_value);
>+extern s32 at_read_phy_reg(struct at_hw *hw, u16 reg_addr, u16 * phy_data);
>+extern s32 at_write_phy_reg(struct at_hw *hw, u32 reg_addr, u16 phy_data);
>+extern s32 at_validate_mdi_setting(struct at_hw *hw);
>+extern void set_mac_addr(struct at_hw *hw);
>+extern int get_permanent_address(struct at_hw *hw);
>+extern s32 at_phy_enter_power_saving(struct at_hw *hw);
>+extern s32 at_reset_hw(struct at_hw *hw);
>+extern void at_check_options(struct at_adapter *adapter);
>+void at_set_ethtool_ops(struct net_device *netdev);

Put externs in a .h file.

>+static u16 at_alloc_rx_buffers(struct at_adapter *adapter)
>+{
...
>+	u16 rfd_next_to_use, next_next;
>+	struct rx_free_desc *rfd_desc;
>+
>+	next_next = rfd_next_to_use = (u16) atomic_read(&rfd_ring->next_to_use);

Cast not needed.

>+		buffer_info->length = (u16) adapter->rx_buffer_len;

>+	rrd_next_to_clean = (u16) atomic_read(&rrd_ring->next_to_clean);

Same (check the others too)

>+			if (++rfd_ring->next_to_clean == rfd_ring->count) {
>+				rfd_ring->next_to_clean = 0;
>+			}
>+		}
>+
>+		buffer_info = &rfd_ring->buffer_info[rrd->buf_indx];
>+		if (++rfd_ring->next_to_clean == rfd_ring->count) {
>+			rfd_ring->next_to_clean = 0;
>+		}

Here is a stylistic one: {} is not needed for single-statememnt ifs.

>+static irqreturn_t at_intr(int irq, void *data)
>+{
>+	struct at_adapter *adapter = ((struct net_device *)data)->priv;

(Ahem)

>+	if (0 == (status = adapter->cmb.cmb->int_stats))

Someone else is probably going to complain about this one...


I have not looked through all of it, so there are sure some more places.

	-`J'
-- 
