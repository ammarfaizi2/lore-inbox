Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbTAHAII>; Tue, 7 Jan 2003 19:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTAHAII>; Tue, 7 Jan 2003 19:08:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:51915 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267647AbTAHAIG>; Tue, 7 Jan 2003 19:08:06 -0500
Date: Tue, 7 Jan 2003 16:18:06 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] EDD: fix raw_data file and edd_has_edd30(), misc cleanups
Message-ID: <20030108001806.GA3669@beaverton.ibm.com>
Mail-Followup-To: Matt Domsch <Matt_Domsch@Dell.com>,
	linux-kernel@vger.kernel.org, mochel@osdl.org,
	linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301071728280.3361-100000@humbolt.us.dell.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch [Matt_Domsch@Dell.com] wrote:
>   * use new find_bus() and bus_for_each_dev() to match SCSI devices

.. snip ..
> +	struct edd_match_data * data = (struct edd_match_data *)d;
> +	struct edd_info *info = edd_dev_get_info(data->edev);
> +	struct scsi_device * sd = to_scsi_device(dev);
> +
> +	if (info) {
> +		if ((sd->channel == info->params.interface_path.pci.channel) &&
> +		    (sd->id == info->params.device_path.scsi.id) &&
> +		    (sd->lun == info->params.device_path.scsi.lun)) {
> +			data->sd = sd;
> +			return 1;
> +		}

This change assumes that the scsi sysfs bus only contains struct
scsi_device's. According to sysfs policy we are suppose to have only one
type of struct on this list, but this is not the case currently.

I will work on a patch tonight to remove these extra nodes so that the
st, sg, and osst maintainers can review it.

-andmike
--
Michael Anderson
andmike@us.ibm.com

