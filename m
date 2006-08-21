Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWHUKxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWHUKxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWHUKxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:53:32 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:32675 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751856AbWHUKxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:53:31 -0400
Message-ID: <44E990A6.90806@de.ibm.com>
Date: Mon, 21 Aug 2006 12:53:26 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
References: <200608181333.23031.ossthema@de.ibm.com> <20060818140506.GC5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818140506.GC5201@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexey Dobriyan wrote:
 > On Fri, Aug 18, 2006 at 01:33:22PM +0200, Jan-Bernd Themann wrote:
 >> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c
 >> +++ kernel/drivers/net/ehea/ehea_ethtool.c
 >> +{
 >> +    strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
 >> +    strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
 >
 > Use strlcpy() to not forget -1 accidently.

Done.

 >
 >> +static u32 netdev_get_msglevel(struct net_device *dev)
 >                        ^^^^^^^^
 >> +{
 >> +    struct ehea_port *port = netdev_priv(dev);
 >> +    return port->msg_enable;
 >                        ^^^^^^
 >
 > Something is mis-named here.

The kernel requires a structure member of that name.

 >> +struct ethtool_ops ehea_ethtool_ops = {
 >> +    .get_settings = netdev_get_settings,
 >> +    .get_drvinfo = netdev_get_drvinfo,
 >> +    .get_msglevel = netdev_get_msglevel,
 >> +    .set_msglevel = netdev_set_msglevel,
 >> +        .get_link = ethtool_op_get_link,
 >> +        .get_tx_csum = ethtool_op_get_tx_csum,
 >
 > Whitespace breakage.

Fixed.

 >> +    .set_settings = NULL,
 >> +    .nway_reset = NULL,
 >> +    .get_pauseparam = NULL,
 >> +    .set_pauseparam = NULL,
 >> +    .get_rx_csum = NULL,
 >> +    .set_rx_csum = NULL,
 >> +    .phys_id = NULL,
 >> +    .self_test = NULL,
 >> +    .self_test_count = NULL
 >
 > If you don't use them, don't mention them at all. Compiler will DTRT.

Agreed. Assignments removed.

Thanks again :-)
Thomas


