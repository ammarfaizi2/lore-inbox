Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267517AbRGMXVC>; Fri, 13 Jul 2001 19:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRGMXUq>; Fri, 13 Jul 2001 19:20:46 -0400
Received: from myth9.Stanford.EDU ([171.64.15.23]:64189 "EHLO
	myth9.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S267517AbRGMXUg>; Fri, 13 Jul 2001 19:20:36 -0400
Date: Fri, 13 Jul 2001 16:20:32 -0700 (PDT)
From: Kenneth Michael Ashcraft <kash@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.stanford.edu>
Subject: [CHECKER] 52 probable security holes in 2.4.6 and 2.4.6-ac2
Message-ID: <Pine.GSO.4.31.0107131616290.8768-100000@myth9.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Here are a bunch of probable security errors.  They have been sorted
into the appropriate source trees:

#  2.4.6-specific errors       	          = 7
#  2.4.6ac2-specific errors               = 9
#  Common errors 		      	  = 36
#  Total 				  = 52

These errors occur because user input (data from copy_from_user, get_user,
etc.) is used without being checked in the following ways:


	1. passed as a length argument to copy_*user (or passed to a
		function that does)
	2. is used as an array index.
	3. used as part of a pointer expression (e.g. ptr + user_value)
	4. passed as the size argument to *malloc (this is a minor bug
		as *malloc will fail if the size is too large, but that
		doesn't seem to be the best way to do bounds checking.)
	5. used as part of the conditional expression of a loop (most of
		the time these errors result in the user being able to
		make the loop go for a long time.)

I would like to extend this checker to look at data received from the network
because those errors would be remotely exploitable.  My understanding is that
this type of data would be in skb->data fields.  Are there other places that
the checker should be looking?  Also, how can we determine if the skb is on
the way in or the way out?  I know that we can look at the number of
assignments to the struct vs the number of assignments from the struct, but
if there is a naming convention or something similar, it would make things a
lot easier.

Further, if anyone has any ideas on other security checks that we should
be doing, please send me an email.

Ken Ashcraft
kash@stanford.edu

# BUGs	|	File Name
3	|	/home/kash/linux/2.4.6/drivers/block/DAC960.c/
3	|	/home/kash/linux/2.4.6/drivers/char/moxa.c/
3	|	/home/kash/linux/2.4.6/drivers/char/drm/mga_bufs.c/
2	|	/home/kash/linux/2.4.6/drivers/net/wan/sdla.c/
2	|	/home/kash/linux/2.4.6/drivers/cdrom/cdrom.c/
2	|	/home/kash/linux/2.4.6/drivers/char/drm/bufs.c/
2	|	/home/kash/linux/2.4.6/drivers/char/drm/i810_bufs.c/
2	|	/home/kash/linux/2.4.6/drivers/scsi/megaraid.c/
2	|	/home/kash/linux/2.4.6/drivers/i2o/i2o_config.c/
2	|	/home/kash/linux/2.4.6/drivers/scsi/scsi_ioctl.c/
2	|	/home/kash/linux/2.4.6/drivers/char/sx.c/
1	|	/home/kash/linux/2.4.6/drivers/md/lvm.c/
1	|	/home/kash/linux/2.4.6/drivers/usb/devio.c/
1	|	/home/kash/linux/2.4.6-ac2/drivers/media/video/stradis.c/
1	|	/home/kash/linux/2.4.6/drivers/net/wan/sdlamain.c/
1	|	/home/kash/linux/2.4.6/drivers/net/wan/lmc/lmc_main.c/
1	|	/home/kash/linux/2.4.6/drivers/i2c/i2c-dev.c/
1	|	/home/kash/linux/2.4.6/drivers/char/drm/ioctl.c/
1	|	/home/kash/linux/2.4.6-ac2/drivers/i2c/i2c-dev.c/
1	|	/home/kash/linux/2.4.6/ipc/sem.c/
1	|	/home/kash/linux/2.4.6/drivers/char/tpqic02.c/
1	|	/home/kash/linux/2.4.6-ac2/drivers/media/video/bttv-driver.c/
1	|	/home/kash/linux/2.4.6-ac2/drivers/md/lvm.c/
1	|	/home/kash/linux/2.4.6/drivers/char/drm/i810_dma.c/
1	|	/home/kash/linux/2.4.6/drivers/block/loop.c/
1	|	/home/kash/linux/2.4.6/drivers/usb/ov511.c/
1	|	/home/kash/linux/2.4.6/drivers/cdrom/sbpcd.c/
1	|	/home/kash/linux/2.4.6/drivers/char/drm/r128_bufs.c/
1	|	/home/kash/linux/2.4.6-ac2/drivers/media/video/zr36120.c/
1	|	/home/kash/linux/2.4.6-ac2/net/irda/af_irda.c/
1	|	/home/kash/linux/2.4.6/net/ipv6/netfilter/ip6_tables.c/
1	|	/home/kash/linux/2.4.6-ac2/net/ipv4/netfilter/ip_tables.c/
1	|	/home/kash/linux/2.4.6/drivers/usb/ibmcam.c/
1	|	/home/kash/linux/2.4.6/drivers/net/wan/sdla_fr.c/
1	|	/home/kash/linux/2.4.6-ac2/net/ipv6/netfilter/ip6_tables.c/
1	|	/home/kash/linux/2.4.6/drivers/char/drm/radeon_bufs.c/
1	|	/home/kash/linux/2.4.6/net/ipv4/netfilter/ip_tables.c/
1	|	/home/kash/linux/2.4.6-ac2/drivers/media/video/zr36067.c/



############################################################
# 2.4.6 specific errors
#
---------------------------------------------------------
[BUG] needs upper-bound check
/home/kash/linux/2.4.6/drivers/block/DAC960.c:5269:DAC960_UserIOCTL: ERROR:RANGE:5235:5269: Using user length "DataTransferLength" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] [linkages -> 5245:DataTransferLength=DataTransferLength -> 5245:UserCommand->DataTransferLength -> 5235:UserCommand:start] [distance=93]
	ProcessorFlags_T ProcessorFlags;
	int ControllerNumber, DataTransferLength;
	unsigned char *DataTransferBuffer = NULL;
	if (UserSpaceUserCommand == NULL) return -EINVAL;
	ErrorCode = copy_from_user(&UserCommand, UserSpaceUserCommand,
Start --->
				   sizeof(DAC960_V1_UserCommand_T));

	... DELETED 28 lines ...

		!= abs(DataTransferLength))
	      return -EINVAL;
	  }
	if (DataTransferLength > 0)
	  {
Error --->
	    DataTransferBuffer = kmalloc(DataTransferLength, GFP_KERNEL);
	    if (DataTransferBuffer == NULL) return -ENOMEM;
	    memset(DataTransferBuffer, 0, DataTransferLength);
	  }
---------------------------------------------------------
[BUG] inlen is signed-- need lower bound check
/home/kash/linux/2.4.6/drivers/scsi/scsi_ioctl.c:266:scsi_ioctl_send_command: ERROR:RANGE:212:266: Using user length "inlen" as argument to "__copy_from_user" [type=LOCAL] [state = need_lb] set by '__get_user':212 [distance=107]
	 * Verify that we can read at least this much.
	 */
	if (verify_area(VERIFY_READ, sic, sizeof(Scsi_Ioctl_Command)))
		return -EFAULT;

Start --->
	__get_user(inlen, &sic->inlen);

	... DELETED 48 lines ...

	__copy_from_user(cmd, cmd_in, cmdlen);

	/*
	 * Obtain the data to be sent to the device (if any).
	 */
Error --->
	__copy_from_user(buf, cmd_in + cmdlen, inlen);

	/*
	 * Set the lun field to the correct value.
---------------------------------------------------------
[BUG] no lower bound check
/home/kash/linux/2.4.6/drivers/scsi/scsi_ioctl.c:323:scsi_ioctl_send_command: ERROR:RANGE:213:323: Using user length "outlen" as argument to "copy_to_user" [type=LOCAL] [state = need_lb] set by '__get_user':213 [distance=127]
	 */
	if (verify_area(VERIFY_READ, sic, sizeof(Scsi_Ioctl_Command)))
		return -EFAULT;

	__get_user(inlen, &sic->inlen);
Start --->
	__get_user(outlen, &sic->outlen);

	... DELETED 104 lines ...


		sb_len = (sb_len > OMAX_SB_LEN) ? OMAX_SB_LEN : sb_len;
		if (copy_to_user(cmd_in, SRpnt->sr_sense_buffer, sb_len))
			result = -EFAULT;
	} else {
Error --->
		if (copy_to_user(cmd_in, buf, outlen))
			result = -EFAULT;
	}

---------------------------------------------------------
[BUG] no upper bound check
/home/kash/linux/2.4.6/drivers/block/DAC960.c:5374:DAC960_UserIOCTL: ERROR:RANGE:5235:5374: Using user length "DataTransferLength" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] [linkages -> 5371:DataTransferLength=DataTransferLength -> 5371:UserCommand->DataTransferLength -> 5235:UserCommand:start]
	ProcessorFlags_T ProcessorFlags;
	int ControllerNumber, DataTransferLength;
	unsigned char *DataTransferBuffer = NULL;
	if (UserSpaceUserCommand == NULL) return -EINVAL;
	ErrorCode = copy_from_user(&UserCommand, UserSpaceUserCommand,
Start --->
				   sizeof(DAC960_V1_UserCommand_T));

	... DELETED 133 lines ...

	if (Controller == NULL) return -ENXIO;
	if (Controller->FirmwareType != DAC960_V2_Controller) return -EINVAL;
	DataTransferLength = UserCommand.DataTransferLength;
	if (DataTransferLength > 0)
	  {
Error --->
	    DataTransferBuffer = kmalloc(DataTransferLength, GFP_KERNEL);
	    if (DataTransferBuffer == NULL) return -ENOMEM;
	    memset(DataTransferBuffer, 0, DataTransferLength);
	  }
---------------------------------------------------------
[BUG] no upper bound check
/home/kash/linux/2.4.6/drivers/block/DAC960.c:5390:DAC960_UserIOCTL: ERROR:RANGE:5235:5390: Using user length "RequestSenseLength" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_ub] [linkages -> 5387:RequestSenseLength=RequestSenseLength -> 5387:UserCommand->RequestSenseLength -> 5235:UserCommand:start]
	ProcessorFlags_T ProcessorFlags;
	int ControllerNumber, DataTransferLength;
	unsigned char *DataTransferBuffer = NULL;
	if (UserSpaceUserCommand == NULL) return -EINVAL;
	ErrorCode = copy_from_user(&UserCommand, UserSpaceUserCommand,
Start --->
				   sizeof(DAC960_V1_UserCommand_T));

	... DELETED 149 lines ...

	    if (ErrorCode != 0) goto Failure2;
	  }
	RequestSenseLength = UserCommand.RequestSenseLength;
	if (RequestSenseLength > 0)
	  {
Error --->
	    RequestSenseBuffer = kmalloc(RequestSenseLength, GFP_KERNEL);
	    if (RequestSenseBuffer == NULL)
	      {
		ErrorCode = -ENOMEM;
---------------------------------------------------------
[BUG] carefully chosen values for length could pass the tests to get to this call.
/home/kash/linux/2.4.6/drivers/scsi/megaraid.c:4032:megadev_ioctl: ERROR:RANGE:3825:4032: Using user length "length" as argument to "copy_to_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':3901 [linkages -> 3901:fcs->length -> 3838:ui->fcs -> 3838:ioc->ui -> 3825:ioc:start] [distance=198]
	ret = verify_area (VERIFY_WRITE, (char *) arg, sizeof (struct uioctl_t));

	if (ret)
		return ret;

Start --->
	if(copy_from_user (&ioc, (char *) arg, sizeof (struct uioctl_t)))

	... DELETED 201 lines ...

		IO_UNLOCK;

		down (&mimd_ioctl_sem);

		if (!scsicmd->result && outlen) {
Error --->
			copy_to_user (uaddr, kphysaddr, ioc.ui.fcs.length);
		}

		/*
---------------------------------------------------------
[BUG] no check at all.
/home/kash/linux/2.4.6/drivers/usb/ibmcam.c:2664:ibmcam_ioctl: ERROR:RANGE:2658:2664: Using user length "frame" as an array index for "frame" [state = tainted] set by 'copy_from_user':2658 [distance=25]
		}
		case VIDIOCSYNC:
		{
			int frame;

Start --->
			if (copy_from_user((void *)&frame, arg, sizeof(int)))
				return -EFAULT;

			if (debug >= 1)
				printk(KERN_DEBUG "ibmcam: syncing to frame %d\n", frame);

Error --->
			switch (ibmcam->frame[frame].grabstate) {
			case FRAME_UNUSED:
				return -EINVAL;
			case FRAME_READY:


############################################################
# 2.4.6ac2 specific errors

#
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.6-ac2/net/ipv4/netfilter/ip_tables.c:1073:do_replace: ERROR:RANGE:1073:1073: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':1073 [linkages -> 1073:tmp->num_counters -> 1073:tmp:start] [distance=1]
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
	}


Error --->
	counters = vmalloc(tmp.num_counters * sizeof(struct ipt_counters));
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.6-ac2/net/ipv6/netfilter/ip6_tables.c:1116:do_replace: ERROR:RANGE:1116:1116: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':1116 [linkages -> 1116:tmp->num_counters -> 1116:tmp:start] [distance=1]
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
	}


Error --->
	counters = vmalloc(tmp.num_counters * sizeof(struct ip6t_counters));
---------------------------------------------------------
[BUG] minor
/home/kash/linux/2.4.6-ac2/drivers/i2c/i2c-dev.c:246:i2cdev_ioctl: ERROR:RANGE:246:246: Using user length "(null)" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':246 [linkages -> 246:rdwr_arg->nmsgs -> 246:rdwr_arg:start] [distance=1]
				   sizeof(rdwr_arg)))
			return -EFAULT;

		rdwr_pa = (struct i2c_msg *)
			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),

Error --->
			GFP_KERNEL);
---------------------------------------------------------
[BUG] looks like it
/home/kash/linux/2.4.6-ac2/net/irda/af_irda.c:2064:irda_getsockopt: ERROR:RANGE:2063:2064: Using user length "(null)" as argument to "copy_to_user" [type=LOCAL] [state = need_lb] [linkages -> 2063:len:start] [distance=3]
			sizeof(struct irda_device_info);

		/* Copy the list itself */
		total = offset + (list.len * sizeof(struct irda_device_info));
		if (total > len)
Start --->
			total = len;
Error --->
		if (copy_to_user(optval+offset, discoveries, total - offset))
			err = -EFAULT;

		/* Write total number of bytes used back to client */
---------------------------------------------------------
[BUG] clipcount is an int so upper bound check can be overridden
/home/kash/linux/2.4.6-ac2/drivers/media/video/zr36120.c:1198:zoran_ioctl: ERROR:RANGE:1192:1198: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = need_lb] set by 'copy_from_user':1198 [linkages -> 1192:vw:start] [distance=12]
		DEBUG(printk(CARD_DEBUG "VIDIOCSWIN(%d,%d,%d,%d,%x,%d)\n",CARD,vw.x,vw.y,vw.width,vw.height,vw.flags,vw.clipcount));

		if (vw.flags)
			return -EINVAL;

Start --->
		if (vw.clipcount>256)
			return -EDOM;   /* Too many! */

		/*
		 *      Do any clips.
		 */
Error --->
		vcp = vmalloc(sizeof(struct video_clip)*(vw.clipcount+4));
		if (vcp==NULL)
			return -ENOMEM;
		if (vw.clipcount && copy_from_user(vcp,vw.clips,sizeof(struct video_clip)*vw.clipcount)) {
---------------------------------------------------------
[BUG] minor.  no upper bound on clipcount
/home/kash/linux/2.4.6-ac2/drivers/media/video/stradis.c:1464:saa_ioctl: ERROR:RANGE:1458:1464: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':1464 [linkages -> 1458:vw:start] [distance=24]
			saa7146_set_winsize(saa);

			/*
			 *    Do any clips.
			 */
Start --->
			if (vw.clipcount < 0) {
				if (copy_from_user(saa->dmavid2, vw.clips,
						   VIDEO_CLIPMAP_SIZE))
					goto out;
			} else if (vw.clipcount > 0) {
				if ((vcp = vmalloc(sizeof(struct video_clip) *
Error --->
					        (vw.clipcount))) == NULL)
				{
					err = -ENOMEM;
					goto out;
---------------------------------------------------------
[BUG] minor.  no upper bound on clipcount
/home/kash/linux/2.4.6-ac2/drivers/media/video/bttv-driver.c:1693:bttv_ioctl: ERROR:RANGE:1680:1693: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = need_ub] set by 'copy_from_user':1693 [linkages -> 1680:vw:start] [distance=24]
		spin_unlock_irqrestore(&btv->s_lock, irq_flags);

		/*
		 *	Do any clips.
		 */
Start --->
		if(vw.clipcount<0) {
			if((vcp=vmalloc(VIDEO_CLIPMAP_SIZE))==NULL) {
				up(&btv->lock);
				return -ENOMEM;
			}
			if(copy_from_user(vcp, vw.clips,
					  VIDEO_CLIPMAP_SIZE)) {
				up(&btv->lock);
				vfree(vcp);
				return -EFAULT;
			}
		} else if (vw.clipcount) {
			if((vcp=vmalloc(sizeof(struct video_clip)*
Error --->
					(vw.clipcount))) == NULL) {
				up(&btv->lock);
				return -ENOMEM;
			}
---------------------------------------------------------
[BUG] minor. no check on clipcount
/home/kash/linux/2.4.6-ac2/drivers/media/video/zr36067.c:3758:do_zoran_ioctl: ERROR:RANGE:3737:3758: Using user length "(null)" as argument to "vmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':3758 [linkages -> 3737:vw:start] [distance=48]
			zr->window.width = vw.width;
			zr->window.height = vw.height;
			zr->window.chromakey = 0;
			zr->window.flags = 0;	// RJ: Is this intended for interlace on/off ?
			zr->window.clips = NULL;
Start --->
			zr->window.clipcount = vw.clipcount;

	... DELETED 15 lines ...

			 *   Write the overlay mask if clips are wanted.
			 */
			if (vw.clipcount) {
				vcp =
				    vmalloc(sizeof(struct video_clip) *
Error --->
					    (vw.clipcount + 4));
				if (vcp == NULL) {
					printk(KERN_ERR
					       "%s: zoran_ioctl: Alloc of clip mask failed\n",
---------------------------------------------------------
[BUG] VG_CHR does nothing
/home/kash/linux/2.4.6-ac2/drivers/md/lvm.c:1400:lvm_do_vg_create: ERROR:RANGE:1398:1400: Using user length "minor" as an array index for "vg" [state = need_ub] [linkages -> 1398:minor=vg_number -> 1398:vg_ptr->vg_number -> 1398:vg_ptr:start] [distance=2]
		kfree(vg_ptr);
		return -EFAULT;
	}

        /* VG_CREATE now uses minor number in VG structure */
Start --->
        if (minor == -1) minor = vg_ptr->vg_number;

Error --->
        if (vg[VG_CHR(minor)] != NULL) {
		kfree(vg_ptr);
  	     	return -EPERM;
	}


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG] kmalloc implicitly checks mem.len, but probably not the best
/home/kash/linux/2.4.6/drivers/net/wan/sdla.c:1201:sdla_xfer: ERROR:RANGE:1196:1201: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':1201 [linkages -> 1201:mem->len -> 1196:mem:start] [distance=23]
static int sdla_xfer(struct net_device *dev, struct sdla_mem *info, int read)
{
	struct sdla_mem mem;
	char	*temp;

Start --->
	if(copy_from_user(&mem, info, sizeof(mem)))
		return -EFAULT;

	if (read)
	{
Error --->
		temp = kmalloc(mem.len, GFP_KERNEL);
		if (!temp)
			return(-ENOMEM);
		sdla_read(dev, mem.addr, temp, mem.len);
---------------------------------------------------------
[BUG] implicit check only
/home/kash/linux/2.4.6/drivers/net/wan/sdla.c:1214:sdla_xfer: ERROR:RANGE:1196:1214: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':1214 [linkages -> 1214:mem->len -> 1196:mem:start] [distance=23]
static int sdla_xfer(struct net_device *dev, struct sdla_mem *info, int read)
{
	struct sdla_mem mem;
	char	*temp;

Start --->
	if(copy_from_user(&mem, info, sizeof(mem)))

	... DELETED 12 lines ...

		}
		kfree(temp);
	}
	else
	{
Error --->
		temp = kmalloc(mem.len, GFP_KERNEL);
		if (!temp)
			return(-ENOMEM);
		if(copy_from_user(temp, mem.data, mem.len))
---------------------------------------------------------
[BUG] not sure: the obvious problem is that vmalloc will indirectly check
      since it will fail if tmp.size is too large.  However, the SMP_ALIGN
      may allow a way to crunch it down.
/home/kash/linux/2.4.6/net/ipv6/netfilter/ip6_tables.c:1111:do_replace: ERROR:RANGE:1102:1111: Using user length "size" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':1106 [linkages -> 1106:tmp->size -> 1102:tmp:start] [distance=24]
	struct ip6t_replace tmp;
	struct ip6t_table *t;
	struct ip6t_table_info *newinfo, *oldinfo;
	struct ip6t_counters *counters;

Start --->
	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
		return -EFAULT;

	newinfo = vmalloc(sizeof(struct ip6t_table_info)
			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
	if (!newinfo)
		return -ENOMEM;

	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
Error --->
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
	}
---------------------------------------------------------
[BUG] doesn't check cmd.length.
/home/kash/linux/2.4.6/drivers/net/wan/sdla_fr.c:1155:wpf_exec: ERROR:RANGE:1146:1155: Using user length "length" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':1154 [linkages -> 1154:cmd->length -> 1146:cmd:start] [distance=24]
	int err, len;
	fr_cmd_t cmd;

#if defined(LINUX_2_1) || defined(LINUX_2_4)

Start --->
	if(copy_from_user((void*)&cmd, u_cmd, sizeof(cmd)))
		return -EFAULT;

	/* execute command */
	do
	{
		memcpy(&mbox->cmd, &cmd, sizeof(cmd));

		if (cmd.length){
Error --->
			if( copy_from_user((void*)&mbox->data, u_data, cmd.length))
				return -EFAULT;
		}

---------------------------------------------------------
[BUG] but mainly can make the kernel allocate unbounded amount of
      memory and crash.
/home/kash/linux/2.4.6/drivers/char/drm/ioctl.c:90:drm_setunique: ERROR:RANGE:82:90: Using user length "unique_len" as argument to "copy_from_user" [type=LOCAL] [state = tainted] [linkages -> 88:unique_len=unique_len -> 88:u->unique_len -> 82:u:start] [distance=25]
	drm_unique_t	 u;

	if (dev->unique_len || dev->unique)
		return -EBUSY;

Start --->
	if (copy_from_user(&u, (drm_unique_t *)arg, sizeof(u)))
		return -EFAULT;

	if (!u.unique_len)
		return -EINVAL;

	dev->unique_len = u.unique_len;
	dev->unique	= drm_alloc(u.unique_len + 1, DRM_MEM_DRIVER);
Error --->
	if (copy_from_user(dev->unique, u.unique, dev->unique_len))
		return -EFAULT;
	dev->unique[dev->unique_len] = '\0';

---------------------------------------------------------
[BUG] no check either way
/home/kash/linux/2.4.6/drivers/net/wan/lmc/lmc_main.c:503:lmc_ioctl: ERROR:RANGE:367:503: Using user length "len" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':503 [linkages -> 503:xc->len -> 367:xc:start] [distance=28]
            /*
             * Stop the xwitter whlie we restart the hardware
             */
            LMC_XMITTER_BUSY(dev);

Start --->
            LMC_COPY_FROM_USER(&xc, ifr->ifr_data, sizeof (struct lmc_xilinx_control));

	... DELETED 130 lines ...

                    if(xc.data == 0x0){
                            ret = -EINVAL;
                            break;
                    }

Error --->
                    data = kmalloc(xc.len, GFP_KERNEL);
                    if(data == 0x0){
                            printk(KERN_WARNING "%s: Failed to allocate memory for copy\n", dev->name);
                            ret = -ENOMEM;
---------------------------------------------------------
[BUG] no check at all
/home/kash/linux/2.4.6/drivers/i2o/i2o_config.c:398:ioctl_parms: ERROR:RANGE:388:398: Using user length "oplen" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':398 [linkages -> 398:kcmd->oplen -> 388:kcmd:start] [distance=35]

	u32 i2o_cmd = (type == I2OPARMGET ?
				I2O_CMD_UTIL_PARAMS_GET :
				I2O_CMD_UTIL_PARAMS_SET);

Start --->
	if(copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_psetget)))
		return -EFAULT;

	if(get_user(reslen, kcmd.reslen))
		return -EFAULT;

	c = i2o_find_controller(kcmd.iop);
	if(!c)
		return -ENXIO;

Error --->
	ops = (u8*)kmalloc(kcmd.oplen, GFP_KERNEL);
	if(!ops)
	{
		i2o_unlock_controller(c);
---------------------------------------------------------
[BUG] MINOR checked indirectly.
/home/kash/linux/2.4.6/net/ipv4/netfilter/ip_tables.c:1068:do_replace: ERROR:RANGE:1055:1068: Using user length "size" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':1059 [linkages -> 1059:tmp->size -> 1055:tmp:start] [distance=35]
	struct ipt_replace tmp;
	struct ipt_table *t;
	struct ipt_table_info *newinfo, *oldinfo;
	struct ipt_counters *counters;

Start --->
	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
		return -EFAULT;

	/* Hack: Causes ipchains to give correct error msg --RR */
	if (len != sizeof(tmp) + tmp.size)
		return -ENOPROTOOPT;

	newinfo = vmalloc(sizeof(struct ipt_table_info)
			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
	if (!newinfo)
		return -ENOMEM;

	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
Error --->
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
	}
---------------------------------------------------------
[BUG]  unchecked int [should print this out in the message]
/home/kash/linux/2.4.6/drivers/char/drm/i810_dma.c:1419:i810_copybuf: ERROR:RANGE:1411:1419: Using user length "used" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':1419 [linkages -> 1419:d->used -> 1411:d:start] [distance=46]
	if(!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("i810_dma called without lock held\n");
		return -EINVAL;
	}

Start --->
   	if (copy_from_user(&d, (drm_i810_copy_t *)arg, sizeof(d)))
		return -EFAULT;

	if(d.idx < 0 || d.idx > dma->buf_count) return -EINVAL;
	buf = dma->buflist[ d.idx ];
   	buf_priv = buf->dev_private;
	if (buf_priv->currently_mapped != I810_BUF_MAPPED) return -EPERM;

Error --->
   	if (copy_from_user(buf_priv->virtual, d.address, d.used))
		return -EFAULT;

   	sarea_priv->last_dispatch = (int) hw_status[5];
---------------------------------------------------------
[BUG]  i think so.  there is a check (dump.offset + dump.length >
card->hw.memory)) that can be fooled with well chosen offset values.

/home/kash/linux/2.4.6/drivers/net/wan/sdlamain.c:1034:ioctl_dump: ERROR:RANGE:972:1034: Using user length "length" as argument to "copy_to_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':982 [linkages -> 982:dump->length -> 972:dump:start] [distance=46]
	unsigned long oldvec;	/* DPM window vector */
	unsigned long smp_flags;
	int err = 0;

      #if defined(LINUX_2_1) || defined(LINUX_2_4)
Start --->
	if(copy_from_user((void*)&dump, (void*)u_dump, sizeof(sdla_dump_t)))

	... DELETED 56 lines ...


	}else {

	     #if defined(LINUX_2_1) || defined(LINUX_2_4)
               if(copy_to_user((void *)dump.ptr,
Error --->
			       (u8 *)card->hw.dpmbase + dump.offset, dump.length)){
			return -EFAULT;
		}
             #else
---------------------------------------------------------
[BUG] only checks that kcmd.qlen is non-zero
/home/kash/linux/2.4.6/drivers/i2o/i2o_config.c:482:ioctl_html: ERROR:RANGE:458:482: Using user length "qlen" as argument to "kmalloc" [type=LOCAL MINOR] [state = tainted] set by 'copy_from_user':480 [linkages -> 480:kcmd->qlen -> 458:kcmd:start] [distance=57]
	int token;
	u32 len;
	u32 reslen;
	u32 msg[MSG_FRAME_SIZE/4];

Start --->
	if(copy_from_user(&kcmd, cmd, sizeof(struct i2o_html)))

	... DELETED 18 lines ...

	if(!c)
		return -ENXIO;

	if(kcmd.qlen) /* Check for post data */
	{
Error --->
		query = kmalloc(kcmd.qlen, GFP_KERNEL);
		if(!query)
		{
			i2o_unlock_controller(c);
---------------------------------------------------------
[BUG] Need a lower-bound check-- lo_encrypt_key_size is an int
/home/kash/linux/2.4.6/drivers/block/loop.c:782:loop_set_status: ERROR:RANGE:757:782: Using user length "lo_encrypt_key_size" as argument to "memcpy" [type=LOCAL] [state = need_lb] set by 'copy_from_user':759 [linkages -> 759:info->lo_encrypt_key_size -> 757:info:start] [distance=110]
	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid &&
	    !capable(CAP_SYS_ADMIN))
		return -EPERM;
	if (lo->lo_state != Lo_bound)
		return -ENXIO;
Start --->
	if (copy_from_user(&info, arg, sizeof (struct loop_info)))

	... DELETED 19 lines ...

	lo->lo_encrypt_key_size = info.lo_encrypt_key_size;
	lo->lo_init[0] = info.lo_init[0];
	lo->lo_init[1] = info.lo_init[1];
	if (info.lo_encrypt_key_size) {
		memcpy(lo->lo_encrypt_key, info.lo_encrypt_key,
Error --->
		       info.lo_encrypt_key_size);
		lo->lo_key_owner = current->uid;
	}
	figure_loop_size(lo);
---------------------------------------------------------
[BUG]  dataxferlen is never checked.
/home/kash/linux/2.4.6/drivers/scsi/megaraid.c:4108:megadev_ioctl: ERROR:RANGE:3825:4108: Using user length "dataxferlen" as argument to "copy_from_user" [type=LOCAL] [state = tainted] set by 'copy_from_user':4108 [linkages -> 4108:pthru->dataxferlen -> 4108:ioc->pthru -> 3825:ioc:start] [distance=124]
	ret = verify_area (VERIFY_WRITE, (char *) arg, sizeof (struct uioctl_t));

	if (ret)
		return ret;

Start --->
	if(copy_from_user (&ioc, (char *) arg, sizeof (struct uioctl_t)))

	... DELETED 277 lines ...

			if (inlen) {
				if (ioc.mbox[0] == MEGA_MBOXCMD_PASSTHRU) {
					/* copyin the user data */
					copy_from_user (kphysaddr,
							uaddr,
Error --->
							ioc.pthru.dataxferlen);
				} else {
					copy_from_user (kphysaddr,
							uaddr, inlen);
---------------------------------------------------------
[BUG] no bounds checking for default case of switch statement
/home/kash/linux/2.4.6/drivers/usb/devio.c:853:proc_submiturb: ERROR:RANGE:761:853: Using user length "buffer_length" as argument to "kmalloc" [type=LOCAL MINOR] [state = need_lb] set by 'copy_from_user':812 [linkages -> 812:uurb->buffer_length -> 761:uurb:start] [distance=137]
	struct async *as;
	devrequest *dr = NULL;
	unsigned int u, totlen, isofrmlen;
	int ret;

Start --->
	if (copy_from_user(&uurb, arg, sizeof(uurb)))

	... DELETED 86 lines ...

			kfree(isopkt);
		if (dr)
			kfree(dr);
		return -ENOMEM;
	}
Error --->
	if (!(as->urb.transfer_buffer = kmalloc(uurb.buffer_length, GFP_KERNEL))) {
		if (isopkt)
			kfree(isopkt);
		if (dr)
---------------------------------------------------------
[BUG] big loop?
/home/kash/linux/2.4.6/ipc/sem.c:857:sys_semop: ERROR:RANGE:857:857: [LOOP] Looping on user length "sop" [nbytes = 6]  [linkages -> 857:sop=sops -> 857:sops:start]
		goto out_free;
	error = -EIDRM;
	if (sem_checkid(sma,semid))
		goto out_unlock_free;
	error = -EFBIG;

Error --->
	for (sop = sops; sop < sops + nsops; sop++) {
---------------------------------------------------------
[BUG] long loop?
/home/kash/linux/2.4.6/drivers/char/sx.c:1713:sx_fw_ioctl: ERROR:RANGE:1712:1713: [LOOP] Looping on user length "data" set by 'get_user':1712

		tmp = kmalloc (SX_CHUNK_SIZE, GFP_USER);
		if (!tmp) return -ENOMEM;
		Get_user (nbytes, descr++);
		Get_user (offset, descr++);
Start --->
		Get_user (data,	 descr++);
Error --->
		while (nbytes && data) {
			for (i=0;i<nbytes;i += SX_CHUNK_SIZE) {
				copy_from_user (tmp, (char *)data+i,
				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
---------------------------------------------------------
[BUG] you could loop for a long time.
/home/kash/linux/2.4.6/drivers/char/drm/mga_bufs.c:485:mga_freebufs: ERROR:RANGE:482:485: [LOOP] Looping on user length "count" set by 'copy_from_user':485 [linkages -> 485:request->count -> 482:request:start]

	if (!dma) return -EINVAL;

	if (copy_from_user(&request,
			   (drm_buf_free_t *)arg,
Start --->
			   sizeof(request)))
		return -EFAULT;

Error --->
	for (i = 0; i < request.count; i++) {
		if (copy_from_user(&idx,
				   &request.list[i],
				   sizeof(idx)))
---------------------------------------------------------
[BUG]  you could loop for a long time.
/home/kash/linux/2.4.6/drivers/char/drm/bufs.c:435:drm_freebufs: ERROR:RANGE:431:435: [LOOP] Looping on user length "count" set by 'copy_from_user':434 [linkages -> 434:request->count -> 431:request:start]

	if (!dma) return -EINVAL;

	if (copy_from_user(&request,
			   (drm_buf_free_t *)arg,
Start --->
			   sizeof(request)))
		return -EFAULT;

	DRM_DEBUG("%d\n", request.count);
Error --->
	for (i = 0; i < request.count; i++) {
		if (copy_from_user(&idx,
				   &request.list[i],
				   sizeof(idx)))
---------------------------------------------------------
[BUG] you could loop for a long time.
/home/kash/linux/2.4.6/drivers/char/drm/i810_bufs.c:311:i810_freebufs: ERROR:RANGE:307:311: [LOOP] Looping on user length "count" set by 'copy_from_user':310 [linkages -> 310:request->count -> 307:request:start]

	if (!dma) return -EINVAL;

	if (copy_from_user(&request,
			   (drm_buf_free_t *)arg,
Start --->
			   sizeof(request)))
		return -EFAULT;

	DRM_DEBUG("%d\n", request.count);
Error --->
	for (i = 0; i < request.count; i++) {
		if (copy_from_user(&idx,
				   &request.list[i],
				   sizeof(idx)))
---------------------------------------------------------
[BUG] big loop?
/home/kash/linux/2.4.6/drivers/char/sx.c:1714:sx_fw_ioctl: ERROR:RANGE:1710:1714: [LOOP] Looping on user length "nbytes" set by 'get_user':1710
			return -EIO;
		sx_dprintk (SX_DEBUG_INIT, "reset the board...\n");

		tmp = kmalloc (SX_CHUNK_SIZE, GFP_USER);
		if (!tmp) return -ENOMEM;
Start --->
		Get_user (nbytes, descr++);
		Get_user (offset, descr++);
		Get_user (data,	 descr++);
		while (nbytes && data) {
Error --->
			for (i=0;i<nbytes;i += SX_CHUNK_SIZE) {
				copy_from_user (tmp, (char *)data+i,
				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
				memcpy_toio    ((char *) (board->base2 + offset + i), tmp,
---------------------------------------------------------
[BUG] not a loop bug because it uses kmalloc to bound check nmsgs, but it is a minor bug because of it.
/home/kash/linux/2.4.6/drivers/i2c/i2c-dev.c:251:i2cdev_ioctl: ERROR:RANGE:241:251: [LOOP] Looping on user length "nmsgs" set by 'copy_from_user':246 [linkages -> 246:rdwr_arg->nmsgs -> 241:rdwr_arg:start]
		                     sizeof(unsigned long)))?-EFAULT:0;

        case I2C_RDWR:
		if (copy_from_user(&rdwr_arg,
				   (struct i2c_rdwr_ioctl_data *)arg,
Start --->
				   sizeof(rdwr_arg)))
			return -EFAULT;

		rdwr_pa = (struct i2c_msg *)
			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),
			GFP_KERNEL);

		if (rdwr_pa == NULL) return -ENOMEM;

		res = 0;
Error --->
		for( i=0; i<rdwr_arg.nmsgs; i++ )
		{
		    	if(copy_from_user(&(rdwr_pa[i]),
					&(rdwr_arg.msgs[i]),
---------------------------------------------------------
[BUG]
static int moxaload320b(int cardno, unsigned char * tmp, int len)
{
        unsigned long baseAddr;
        int i;
        if(copy_from_user(moxaBuff, tmp, len))
                return -EFAULT;
/home/kash/linux/2.4.6/drivers/char/moxa.c:1730:MoxaDriverIoctl: ERROR:RANGE:1719:1730: Using user length "len" as argument to "moxaload320b" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1730 [linkages -> 1730:dltmp->len -> 1719:dltmp:start]
		}
		if(copy_to_user((void *)arg, temp_queue, sizeof(struct moxaq_str) * MAX_PORTS))
			return -EFAULT;
		return (0);
	case MOXA_LOAD_BIOS:
Start --->
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;
		i = moxaloadbios(dltmp.cardno, dltmp.buf, dltmp.len);
		return (i);
	case MOXA_FIND_BOARD:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;
		return moxafindcard(dltmp.cardno);
	case MOXA_LOAD_C320B:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;
Error --->
		moxaload320b(dltmp.cardno, dltmp.buf, dltmp.len);
		return (0);
	case MOXA_LOAD_CODE:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
---------------------------------------------------------
[BUG] moxaloadbios does no checking
/home/kash/linux/2.4.6/drivers/char/moxa.c:1721:MoxaDriverIoctl: ERROR:RANGE:1719:1721: Using user length "len" as argument to "moxaloadbios" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1721 [linkages -> 1721:dltmp->len -> 1719:dltmp:start] [distance=12]
		}
		if(copy_to_user((void *)arg, temp_queue, sizeof(struct moxaq_str) * MAX_PORTS))
			return -EFAULT;
		return (0);
	case MOXA_LOAD_BIOS:
Start --->
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;
Error --->
		i = moxaloadbios(dltmp.cardno, dltmp.buf, dltmp.len);
		return (i);
	case MOXA_FIND_BOARD:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
---------------------------------------------------------
[BUG] there look to be a bunch of errors in this function
/home/kash/linux/2.4.6/drivers/char/moxa.c:1735:MoxaDriverIoctl: ERROR:RANGE:1719:1735: Using user length "len" as argument to "moxaloadcode" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1735 [linkages -> 1735:dltmp->len -> 1719:dltmp:start]
		}
		if(copy_to_user((void *)arg, temp_queue, sizeof(struct moxaq_str) * MAX_PORTS))
			return -EFAULT;
		return (0);
	case MOXA_LOAD_BIOS:
Start --->
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))

	... DELETED 10 lines ...

		moxaload320b(dltmp.cardno, dltmp.buf, dltmp.len);
		return (0);
	case MOXA_LOAD_CODE:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;
Error --->
		i = moxaloadcode(dltmp.cardno, dltmp.buf, dltmp.len);
		if (i == -1)
			return (-EFAULT);
		return (i);
---------------------------------------------------------
[BUG] needs upper bound
/home/kash/linux/2.4.6/drivers/cdrom/cdrom.c:2017:mmc_ioctl: ERROR:RANGE:1998:2017: [LOOP] Looping on user length "nr" [linkages -> 2016:nr=nframes -> 2016:ra->nframes -> 1998:ra:start]
		}
	case CDROMREADAUDIO: {
		struct cdrom_read_audio ra;
		int lba, nr;

Start --->
		IOCTL_IN(arg, struct cdrom_read_audio, ra);

	... DELETED 13 lines ...


		/*
		 * start with will ra.nframes size, back down if alloc fails
		 */
		nr = ra.nframes;
Error --->
		do {
			cgc.buffer = kmalloc(CD_FRAMESIZE_RAW * nr, GFP_KERNEL);
			if (cgc.buffer)
				break;
---------------------------------------------------------
[BUG]
/home/kash/linux/2.4.6/drivers/md/lvm.c:2729:lvm_do_lv_status_byindex: ERROR:RANGE:2724:2729: Using user length "lv_index" as an array index for "lv" [state = tainted] set by 'copy_from_user':2729 [linkages -> 2729:lv_status_byindex_req->lv_index -> 2724:lv_status_byindex_req:start] [distance=23]
	lv_t *lv_ptr;
	lv_status_byindex_req_t lv_status_byindex_req;

	if (vg_ptr == NULL) return -ENXIO;
	if (copy_from_user(&lv_status_byindex_req, arg,
Start --->
			   sizeof(lv_status_byindex_req)) != 0)
		return -EFAULT;

	if ((lvp = lv_status_byindex_req.lv) == NULL)
		return -EINVAL;
Error --->
	if ( ( lv_ptr = vg_ptr->lv[lv_status_byindex_req.lv_index]) == NULL)
		return -ENXIO;

	if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0)
---------------------------------------------------------
[BUG] no bounds check
/home/kash/linux/2.4.6/drivers/usb/ov511.c:2524:ov511_ioctl: ERROR:RANGE:2518:2524: Using user length "frame" as an array index for "frame" [state = tainted] set by 'copy_from_user':2518 [distance=23]
	}
	case VIDIOCSYNC:
	{
		int frame;

Start --->
		if (copy_from_user((void *)&frame, arg, sizeof(int)))
			return -EFAULT;

		PDEBUG(4, "syncing to frame %d, grabstate = %d", frame,
		       ov511->frame[frame].grabstate);

Error --->
		switch (ov511->frame[frame].grabstate) {
		case FRAME_UNUSED:
			return -EINVAL;
		case FRAME_READY:
---------------------------------------------------------
[BUG] even the implementor agrees

		else
			return -EINVAL;
		/* FIXME: we need upper bound checking, too!! */
		if (lba < 0 || ra.nframes <= 0)
			return -EINVAL;
/home/kash/linux/2.4.6/drivers/cdrom/cdrom.c:2033:mmc_ioctl: ERROR:RANGE:1998:2033: [LOOP] Looping on user length "nframes" set by 'copy_from_user':2010 [linkages -> 2010:ra->nframes -> 1998:ra:start]
		}
	case CDROMREADAUDIO: {
		struct cdrom_read_audio ra;
		int lba, nr;

Start --->
		IOCTL_IN(arg, struct cdrom_read_audio, ra);

	... DELETED 29 lines ...

		if (!access_ok(VERIFY_WRITE, ra.buf, ra.nframes*CD_FRAMESIZE_RAW)) {
			kfree(cgc.buffer);
			return -EFAULT;
		}
		cgc.data_direction = CGC_DATA_READ;
Error --->
		while (ra.nframes > 0) {
			if (nr > ra.nframes)
				nr = ra.nframes;

---------------------------------------------------------
[BUG] no direct check on count
/home/kash/linux/2.4.6/drivers/char/drm/i810_bufs.c:104:i810_addbufs_agp: ERROR:RANGE:61:104: [LOOP] Looping on user length "count" [linkages -> 64:count=count -> 64:request->count -> 61:request:start]

	if (!dma) return -EINVAL;

	if (copy_from_user(&request,
			   (drm_buf_desc_t *)arg,
Start --->
			   sizeof(request)))

	... DELETED 37 lines ...


	entry->buf_size   = size;
	entry->page_order = page_order;
	offset = 0;

Error --->
	while(entry->buf_count < count) {
		buf = &entry->buflist[entry->buf_count];
		buf->idx = dma->buf_count + entry->buf_count;
		buf->total = alignment;
---------------------------------------------------------
[BUG] big loop?
/home/kash/linux/2.4.6/drivers/char/tpqic02.c:2692:qic02_tape_ioctl: ERROR:RANGE:2645:2692: [LOOP] Looping on user length "mt_count" set by 'copy_from_user':2660 [linkages -> 2660:operation->mt_count -> 2645:operation:start]
    if (c == _IOC_NR(MTIOCTOP))
    {
	CHECK_IOC_SIZE(mtop);

	/* copy mtop struct from user space to kernel space */
Start --->
	if (copy_from_user((char *) &operation, (char *) ioarg, sizeof(operation)))

	... DELETED 41 lines ...


	    ioctl_status.mt_resid = 0;
	}
	else
	{
Error --->
	    while (operation.mt_count > 0)
	    {
		operation.mt_count--;
		if ((error = do_ioctl_cmd(operation.mt_op)) != 0)
---------------------------------------------------------
[BUG] no direct check on count
/home/kash/linux/2.4.6/drivers/char/drm/mga_bufs.c:115:mga_addbufs_agp: ERROR:RANGE:62:115: [LOOP] Looping on user length "count" [linkages -> 65:count=count -> 65:request->count -> 62:request:start]

	if (!dma) return -EINVAL;

	if (copy_from_user(&request,
			   (drm_buf_desc_t *)arg,
Start --->
			   sizeof(request)))

	... DELETED 47 lines ...

	entry->buf_size   = size;
	entry->page_order = page_order;
	offset = 0;


Error --->
	while(entry->buf_count < count) {
		buf = &entry->buflist[entry->buf_count];
		buf->idx = dma->buf_count + entry->buf_count;
		buf->total = alignment;
---------------------------------------------------------
[BUG] no direct check on count
/home/kash/linux/2.4.6/drivers/char/drm/radeon_bufs.c:116:radeon_addbufs_agp: ERROR:RANGE:62:116: [LOOP] Looping on user length "count" [linkages -> 65:count=count -> 65:request->count -> 62:request:start]
	int               byte_count;
	int               i;

	if (!dma) return -EINVAL;

Start --->
	if (copy_from_user(&request, (drm_buf_desc_t *)arg, sizeof(request)))

	... DELETED 48 lines ...


	entry->buf_size   = size;
	entry->page_order = page_order;
	offset            = 0;

Error --->
	for (offset = 0;
	     entry->buf_count < count;
	     offset += alignment, ++entry->buf_count) {
		buf          = &entry->buflist[entry->buf_count];
---------------------------------------------------------
[BUG] no direct check on count
/home/kash/linux/2.4.6/drivers/char/drm/r128_bufs.c:119:r128_addbufs_agp: ERROR:RANGE:65:119: [LOOP] Looping on user length "count" [linkages -> 68:count=count -> 68:request->count -> 65:request:start]

	if (!dma) return -EINVAL;

	if (copy_from_user(&request,
			   (drm_buf_desc_t *)arg,
Start --->
			   sizeof(request)))

	... DELETED 48 lines ...


	entry->buf_size   = size;
	entry->page_order = page_order;
	offset            = 0;

Error --->
	for (offset = 0;
	     entry->buf_count < count;
	     offset += alignment, ++entry->buf_count) {
		buf          = &entry->buflist[entry->buf_count];
---------------------------------------------------------
[BUG] no direct check on count
/home/kash/linux/2.4.6/drivers/char/drm/mga_bufs.c:287:mga_addbufs_pci: ERROR:RANGE:220:287: [LOOP] Looping on user length "count" [linkages -> 223:count=count -> 223:request->count -> 220:request:start]

	if (!dma) return -EINVAL;

	if (copy_from_user(&request,
			   (drm_buf_desc_t *)arg,
Start --->
			   sizeof(request)))

	... DELETED 61 lines ...


	entry->buf_size	  = size;
	entry->page_order = page_order;
	byte_count	  = 0;
	page_count	  = 0;
Error --->
	while (entry->buf_count < count) {
		if (!(page = drm_alloc_pages(page_order, DRM_MEM_DMA))) break;
		entry->seglist[entry->seg_count++] = page;
		for (i = 0; i < (1 << page_order); i++) {
---------------------------------------------------------
[BUG] no direct check on count
/home/kash/linux/2.4.6/drivers/char/drm/bufs.c:239:drm_addbufs: ERROR:RANGE:172:239: [LOOP] Looping on user length "count" [linkages -> 175:count=count -> 175:request->count -> 172:request:start]

	if (!dma) return -EINVAL;

	if (copy_from_user(&request,
			   (drm_buf_desc_t *)arg,
Start --->
			   sizeof(request)))

	... DELETED 61 lines ...


	entry->buf_size	  = size;
	entry->page_order = page_order;
	byte_count	  = 0;
	page_count	  = 0;
Error --->
	while (entry->buf_count < count) {
		if (!(page = drm_alloc_pages(page_order, DRM_MEM_DMA))) break;
		entry->seglist[entry->seg_count++] = page;
		for (i = 0; i < (1 << page_order); i++) {
---------------------------------------------------------
[BUG] This value is upper bounded but not lower.  It also gets assigned to an unsigned char on line 4364 and later is used as the length argument to copy_to_user
/home/kash/linux/2.4.6/drivers/cdrom/sbpcd.c:4432:sbpcd_dev_ioctl: ERROR:RANGE:4310:4432: Using user length "nframes" as part of a pointer expression "aud_buf" set by 'copy_from_user':4311 [linkages -> 4311:read_audio->nframes -> 4310:read_audio:start] [distance=252]
		if (D_S[d].has_data>1) RETURN_UP(-EBUSY);
#endif /* SAFE_MIXED */
		if (D_S[d].aud_buf==NULL) RETURN_UP(-EINVAL);
		i=verify_area(VERIFY_READ, (void *) arg, sizeof(struct cdrom_read_audio));
		if (i) RETURN_UP(i);
Start --->
		copy_from_user(&read_audio, (void *) arg, sizeof(struct cdrom_read_audio));

	... DELETED 116 lines ...

				if (sbpro_type==1) OUT(CDo_sel_i_d,1);
				if (do_16bit)
				{
					u_short *p2 = (u_short *) p;

Error --->
					for (; (u_char *) p2 < D_S[d].aud_buf + read_audio.nframes*CD_FRAMESIZE_RAW;)
				  	{
						if ((inb_p(CDi_status)&s_not_data_ready)) continue;





