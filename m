Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWHKLkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWHKLkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 07:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWHKLkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 07:40:40 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:42329 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932143AbWHKLkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 07:40:39 -0400
Message-ID: <44DC63B4.9070405@de.ibm.com>
Date: Fri, 11 Aug 2006 13:02:12 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Christian Borntraeger <borntrae@de.ibm.com>
CC: netdev <netdev@vger.kernel.org>, linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
References: <44D99EFC.3000105@de.ibm.com> <200608091108.51774.borntrae@de.ibm.com>
In-Reply-To: <200608091108.51774.borntrae@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

thanks for your comments, we'll send an updated patch set soon.

Jan-Bernd

Christian Borntraeger wrote:
> Hi Jan-Bernd,
> 
> I had some minutes, here are some finding after a quick look.
> 
> On Wednesday 09 August 2006 10:38, you wrote:
>> +static struct net_device_stats *ehea_get_stats(struct net_device *dev)
>> +{
>> +	int i;
>> +	u64 hret = H_HARDWARE;
>> +	u64 rx_packets = 0;
>> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
> 
> dev->priv is a void pointer, this cast is unnecessary. When we are at it, have 
> you considered the netdev_priv macro? This will require some prep in 
> alloc_netdev and might not always pe possible. 

good point, we'll use alloc_etherdev / netdev_priv

>> +
>> +	EDEB_DMP(7, (u8*)cb2,
>> +		 sizeof(struct hcp_query_ehea_port_cb_2), "After HCALL");
>> +
>> +	for (i = 0; i < port->num_def_qps; i++) {
>> +		rx_packets += port->port_res[i].rx_packets;
>> +	}
>> +
>> +	stats->tx_packets = cb2->txucp + cb2->txmcp + cb2->txbcp;
>> +	stats->multicast = cb2->rxmcp;
>> +	stats->rx_errors = cb2->rxuerr;
>> +	stats->rx_bytes = cb2->rxo;
>> +	stats->tx_bytes = cb2->txo;
>> +	stats->rx_packets = rx_packets;
>> +
>> +get_stat_exit:
>> +	EDEB_EX(7, "");
>> +	return stats;
>> +}
> 
> again, cb2 is not freed.
> [...]

yep, done

> 
>> +static inline u64 get_swqe_addr(u64 tmp_addr, int addr_seg)
>> +{
>> +	u64 addr;
>> +	addr = tmp_addr;
>> +	return addr;
>> +}
> 
> This is suppsed to change in the future? If not you can get rid of it. 
> 
>> +
>> +static inline u64 get_rwqe_addr(u64 tmp_addr)
>> +{
>> +	return tmp_addr;
>> +}
> 
> same here. 

removed


>> + ehea_poll()
> 
> The poll function seems too long and therefore hard to review. Please consider 
> splitting it. 
> 
> 

done

