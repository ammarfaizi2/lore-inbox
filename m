Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVHYTKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVHYTKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVHYTKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:10:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12929 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932283AbVHYTKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:10:02 -0400
Date: Thu, 25 Aug 2005 20:09:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       mochel@osdl.org, "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: 2.6: how do I this in sysfs?
Message-ID: <20050825190951.GA20812@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Miller, Mike (OS Dev)" <Mike.Miller@hp.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	greg@kroah.com, mochel@osdl.org,
	"Moore, Eric Dean" <Eric.Moore@lsil.com>,
	"Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>
References: <D4CFB69C345C394284E4B78B876C1CF10AB38B33@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10AB38B33@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > typedef struct _CSMI_SAS_IDENTIFY {
> >    __u8  bDeviceType;
> >    __u8  bRestricted;
> >    __u8  bInitiatorPortProtocol;
> >    __u8  bTargetPortProtocol;
> >    __u8  bRestricted2[8];
> >    __u8  bSASAddress[8];
> >    __u8  bPhyIdentifier;
> >    __u8  bSignalClass;
> >    __u8  bReserved[6];
> > } CSMI_SAS_IDENTIFY,
> >   *PCSMI_SAS_IDENTIFY;

please compare this with struct sas_identify in
include/linux/scsi_transport_sas.h and look at
drivers/scsi/scsi_transport_sas.c om how it's exposed.

> > typedef struct _CSMI_SAS_PHY_ENTITY {
> >    CSMI_SAS_IDENTIFY Identify;
> >    __u8  bPortIdentifier;
> >    __u8  bNegotiatedLinkRate;
> >    __u8  bMinimumLinkRate;
> >    __u8  bMaximumLinkRate;
> >    __u8  bPhyChangeCount;
> >    __u8  bAutoDiscover;
> >    __u8  bReserved[2];
> >    CSMI_SAS_IDENTIFY Attached;
> > } CSMI_SAS_PHY_ENTITY,
> >   *PCSMI_SAS_PHY_ENTITY;

and this one to struct sas_port_attrs.

This is after my minimal sas transport class, please also read the
thread about it on linux-scsi

