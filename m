Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbRHAOg5>; Wed, 1 Aug 2001 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbRHAOgv>; Wed, 1 Aug 2001 10:36:51 -0400
Received: from eagle.mkssoftware.com ([204.255.0.2]:47769 "EHLO
	hercules.fairfax.datafocus.com") by vger.kernel.org with ESMTP
	id <S267148AbRHAOge>; Wed, 1 Aug 2001 10:36:34 -0400
Message-ID: <001801c11a96$ef57a680$4d0310ac@fairfax.mkssoftware.com>
From: "Eric Youngdale" <eric@andante.org>
To: "Mike Panetta" <mpanetta@applianceware.com>
Cc: "Richard Gooch" <rgooch@ras.ucalgary.ca>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        <devfs-announce-list@mobilix.ras.ucalgary.ca>
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca> <001801c119ca$9fc74750$4d0310ac@fairfax.mkssoftware.com> <20010731153808.B6638@tetsuo.applianceware.com>
Subject: Re: [RFT] Support for ~2144 SCSI discs
Date: Wed, 1 Aug 2001 10:33:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Potentially yes, although that doesn't have so much to do with the disk
driver proper.  The first goal is to rid ourselves of some baggage that make
it harder to move forward.

-Eric

----- Original Message -----
From: "Mike Panetta" <mpanetta@applianceware.com>
To: "Eric Youngdale" <eric@andante.org>
Cc: "Richard Gooch" <rgooch@ras.ucalgary.ca>;
<linux-kernel@vger.kernel.org>; <linux-scsi@vger.kernel.org>;
<devfs-announce-list@mobilix.ras.ucalgary.ca>
Sent: Tuesday, July 31, 2001 6:38 PM
Subject: Re: [RFT] Support for ~2144 SCSI discs


> Any maybe target mode?  That would be nice to
> have :) Or is it already here?
>
> Mike
>
> On Tue, Jul 31, 2001 at 10:10:59AM -0400, Eric Youngdale wrote:
> >
> >     FYI - At some point in the 2.5 series I would like to do some
serious
> > surgery on the sd datastructures - this will mainly remove load order
> > dependencies and eliminate the need for CONFIG_SD_EXTRA.  I believe that
> > some of the work that Jens has already started on the blk device layer
will
> > make support for very large numbers of disks much easier.
> >
> > -Eric
> >
> > ----- Original Message -----
> > From: "Richard Gooch" <rgooch@ras.ucalgary.ca>
> > To: <linux-kernel@vger.kernel.org>; <linux-scsi@vger.kernel.org>
> > Cc: <devfs-announce-list@mobilix.ras.ucalgary.ca>
> > Sent: Monday, July 30, 2001 8:30 PM
> > Subject: [RFT] Support for ~2144 SCSI discs
> >
> >
> > >   Hi, all. Below is a patch that adds support for large numbers of
> > > SCSI discs (approximately 2144). I'd like people to try this out. I'm
> > > not doing my normal devfs-patch-v??? thing because this is completely
> > > untested (I'm away from my SCSI boxes), and I don't want to put a
> > > possibly FS-corrupting patch on my ftp archive. The code does compile
> > > and link, though.
> > >
> > > There are 3 cases I'd like to have tested:
> > > - people with 1 to 16 SCSI discs
> > > - people with 17 to 128 SCSI discs
> > > - people with >128 SCSI discs
> > >
> > > because each of these exercises a slightly different setup path.
> > > Please send success or failure reports to me.
> > >
> > > REMINDER: be careful with this patch. It could corrupt your FS.
> > >
> > > Regards,
> > >
> > > Richard....
> > > Permanent: rgooch@atnf.csiro.au
> > > Current:   rgooch@ras.ucalgary.ca
> > >
> > > diff -urN linux-2.4.7/Documentation/Configure.help
> > linux/Documentation/Configure.help
> > > --- linux-2.4.7/Documentation/Configure.help Thu Jul 19 20:48:15 2001
> > > +++ linux/Documentation/Configure.help Mon Jul 23 01:19:24 2001
> > > @@ -5410,6 +5410,17 @@
> > >    located on a SCSI disk. In this case, do not compile the driver for
> > >    your SCSI host adapter (below) as a module either.
> > >
> > > +Many SCSI Discs support
> > > +CONFIG_SD_MANY
> > > +  This allows you to support a very large number of SCSI discs
> > > +  (approximately 2144). You will also need to set CONFIG_DEVFS_FS=y
> > > +  later. This option may consume all unassigned block majors
> > > +  (i.e. those which do not have an allocation in
> > > +  Documentation/devices.txt). Enabling this will consume a few extra
> > > +  kilobytes of kernel memory.
> > > +
> > > +  Unless you have a large storage array, say N.
> > > +
> > >  Extra SCSI Disks
> > >  CONFIG_SD_EXTRA_DEVS
> > >    This controls the amount of additional space allocated in tables
for
> > > diff -urN linux-2.4.7/Documentation/filesystems/devfs/ChangeLog
> > linux/Documentation/filesystems/devfs/ChangeLog
> > > --- linux-2.4.7/Documentation/filesystems/devfs/ChangeLog Wed Jul 11
> > 17:55:41 2001
> > > +++ linux/Documentation/filesystems/devfs/ChangeLog Mon Jul 30
19:13:00
> > 2001
> > > @@ -1675,3 +1675,13 @@
> > >  - Fixed number leak for /dev/cdroms/cdrom%d
> > >
> > >  - Fixed number leak for /dev/discs/disc%d
> > >
> >
+===========================================================================
> > ====
> > > +Changes for patch v183
> > > +
> > > +- Fixed bug in <devfs_setup> which could hang boot process
> > >
> >
+===========================================================================
> > ====
> > > +Changes for patch v184
> > > +
> > > +- Support large numbers of SCSI discs (~2144)
> > > +
> > > +- Documentation typo fix for fs/devfs/util.c
> > > diff -urN linux-2.4.7/drivers/scsi/Config.in
linux/drivers/scsi/Config.in
> > > --- linux-2.4.7/drivers/scsi/Config.in Thu Jul  5 14:28:16 2001
> > > +++ linux/drivers/scsi/Config.in Mon Jul 23 01:19:47 2001
> > > @@ -3,7 +3,8 @@
> > >  dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
> > >
> > >  if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
> > > -   int  'Maximum number of SCSI disks that can be loaded as modules'
> > CONFIG_SD_EXTRA_DEVS 40
> > > +   bool '    Many (~2144) SCSI discs support (requires devfs)'
> > CONFIG_SD_MANY
> > > +   int  '    Maximum number of SCSI disks that can be loaded as
modules'
> > CONFIG_SD_EXTRA_DEVS 40
> > >  fi
> > >
> > >  dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
> > > diff -urN linux-2.4.7/drivers/scsi/hosts.h linux/drivers/scsi/hosts.h
> > > --- linux-2.4.7/drivers/scsi/hosts.h Fri Jul 20 15:55:46 2001
> > > +++ linux/drivers/scsi/hosts.h Mon Jul 30 19:20:27 2001
> > > @@ -506,9 +506,8 @@
> > >      const char * tag;
> > >      struct module * module;   /* Used for loadable modules */
> > >      unsigned char scsi_type;
> > > -    unsigned int major;
> > > -    unsigned int min_major;      /* Minimum major in range. */
> > > -    unsigned int max_major;      /* Maximum major in range. */
> > > +    unsigned int *majors;         /* Array of majors used by driver
*/
> > > +    unsigned int num_majors;      /* Number of majors used by driver
*/
> > >      unsigned int nr_dev;   /* Number currently attached */
> > >      unsigned int dev_noticed;   /* Number of devices detected. */
> > >      unsigned int dev_max;   /* Current size of arrays */
> > > diff -urN linux-2.4.7/drivers/scsi/osst.c linux/drivers/scsi/osst.c
> > > --- linux-2.4.7/drivers/scsi/osst.c Fri Jul 20 00:18:15 2001
> > > +++ linux/drivers/scsi/osst.c Mon Jul 30 17:57:27 2001
> > > @@ -160,7 +160,6 @@
> > >         name: "OnStream tape",
> > >         tag: "osst",
> > >         scsi_type: TYPE_TAPE,
> > > -       major: OSST_MAJOR,
> > >         detect: osst_detect,
> > >         init: osst_init,
> > >         attach: osst_attach,
> > > diff -urN linux-2.4.7/drivers/scsi/scsi_lib.c
> > linux/drivers/scsi/scsi_lib.c
> > > --- linux-2.4.7/drivers/scsi/scsi_lib.c Thu Jul 19 23:48:04 2001
> > > +++ linux/drivers/scsi/scsi_lib.c Mon Jul 30 17:52:35 2001
> > > @@ -769,25 +769,10 @@
> > >   * Search for a block device driver that supports this
> > >   * major.
> > >   */
> > > - if (spnt->blk && spnt->major == major) {
> > > - return spnt;
> > > - }
> > > - /*
> > > - * I am still not entirely satisfied with this solution,
> > > - * but it is good enough for now.  Disks have a number of
> > > - * major numbers associated with them, the primary
> > > - * 8, which we test above, and a secondary range of 7
> > > - * different consecutive major numbers.   If this ever
> > > - * becomes insufficient, then we could add another function
> > > - * to the structure, and generalize this completely.
> > > - */
> > > - if( spnt->min_major != 0
> > > -     && spnt->max_major != 0
> > > -     && major >= spnt->min_major
> > > -     && major <= spnt->max_major )
> > > - {
> > > - return spnt;
> > > - }
> > > + int i;
> > > + if (!spnt->blk || !spnt->majors) continue;
> > > + for (i = 0; i < spnt->num_majors; ++i)
> > > + if (spnt->majors[i] == major) return spnt;
> > >   }
> > >   return NULL;
> > >  }
> > > diff -urN linux-2.4.7/drivers/scsi/sd.c linux/drivers/scsi/sd.c
> > > --- linux-2.4.7/drivers/scsi/sd.c Thu Jul  5 14:28:17 2001
> > > +++ linux/drivers/scsi/sd.c Mon Jul 30 20:10:58 2001
> > > @@ -28,6 +28,8 @@
> > >   *
> > >   * Modified by Alex Davis <letmein@erols.com>
> > >   *       Fix problem where removable media could be ejected after
> > sd_open.
> > > + *
> > > + *       Modified by Richard Gooch rgooch@atnf.csiro.au to support
>128
> > discs.
> > >   */
> > >
> > >  #include <linux/config.h>
> > > @@ -65,7 +67,7 @@
> > >   *  static const char RCSid[] = "$Header:";
> > >   */
> > >
> > > -#define SD_MAJOR(i) (!(i) ? SCSI_DISK0_MAJOR :
SCSI_DISK1_MAJOR-1+(i))
> > > +#define SD_MAJOR(i) sd_template.majors[(i)]
> > >
> > >  #define SCSI_DISKS_PER_MAJOR 16
> > >  #define SD_MAJOR_NUMBER(i) SD_MAJOR((i) >> 8)
> > > @@ -108,12 +110,6 @@
> > >   name:"disk",
> > >   tag:"sd",
> > >   scsi_type:TYPE_DISK,
> > > - major:SCSI_DISK0_MAJOR,
> > > -        /*
> > > -         * Secondary range of majors that this driver handles.
> > > -         */
> > > - min_major:SCSI_DISK1_MAJOR,
> > > - max_major:SCSI_DISK7_MAJOR,
> > >   blk:1,
> > >   detect:sd_detect,
> > >   init:sd_init,
> > > @@ -123,6 +119,19 @@
> > >   init_command:sd_init_command,
> > >  };
> > >
> > > +#ifdef CONFIG_SD_MANY
> > > +static inline int sd_devnum_to_index (int devnum)
> > > +{
> > > +    int i, major = MAJOR (devnum);
> > > +
> > > +    for (i = 0; i < sd_template.num_majors; ++i)
> > > +    {
> > > +        if (sd_template.majors[i] != major) continue;
> > > +        return (i << 4) | (MINOR (i) >> 4);
> > > +    }
> > > +    return -ENODEV;
> > > +}
> > > +#endif
> > >
> > >  static void rw_intr(Scsi_Cmnd * SCpnt);
> > >
> > > @@ -1043,6 +1052,41 @@
> > >   return i;
> > >  }
> > >
> > > +static int sd_alloc_majors (void)
> > > +/*  Allocate as many majors as required
> > > + */
> > > +{
> > > + int i, major;
> > > +
> > > + if ( ( sd_template.majors =
> > > +        kmalloc (sizeof sd_template.majors * N_USED_SD_MAJORS,
> > > + GFP_ATOMIC) ) == NULL ) {
> > > + printk ("sd.c: unable to allocate major array\n");
> > > + return -ENOMEM;
> > > + }
> > > + sd_template.majors[0] = SCSI_DISK0_MAJOR;
> > > + for (i = 1; (i < N_USED_SD_MAJORS) && (i
<N_SD_PREASSIGNED_MAJORS);++i)
> > > + sd_template.majors[i] = SCSI_DISK1_MAJOR + i - 1;
> > > + for (; (i >= N_SD_PREASSIGNED_MAJORS) && (i < N_USED_SD_MAJORS);
++i) {
> > > + if ( ( major = devfs_alloc_major (DEVFS_SPECIAL_BLK) ) < 0 )
> > > + break;
> > > + sd_template.majors[i] = major;
> > > + }
> > > + sd_template.dev_max = i * SCSI_DISKS_PER_MAJOR;
> > > + sd_template.num_majors = i;
> > > + return 0;
> > > +} /*  End Function sd_alloc_majors  */
> > > +
> > > +static void sd_dealloc_majors (void)
> > > +/*  Deallocate all the allocated majors
> > > + */
> > > +{
> > > + int i;
> > > +
> > > + for (i = sd_template.num_majors - 1; i >=
N_SD_PREASSIGNED_MAJORS; --i)
> > > + devfs_dealloc_major (DEVFS_SPECIAL_BLK, sd_template.majors[i]);
> > > +} /*  End Function sd_dealloc_majors  */
> > > +
> > >  /*
> > >   * The sd_init() function looks at all SCSI drives present,
determines
> > >   * their size, and reads partition table entries for them.
> > > @@ -1057,16 +1101,16 @@
> > >   if (sd_template.dev_noticed == 0)
> > >   return 0;
> > >
> > > - if (!rscsi_disks)
> > > + if (!rscsi_disks) {
> > >   sd_template.dev_max = sd_template.dev_noticed + SD_EXTRA_DEVS;
> > > -
> > > - if (sd_template.dev_max > N_SD_MAJORS * SCSI_DISKS_PER_MAJOR)
> > > - sd_template.dev_max = N_SD_MAJORS * SCSI_DISKS_PER_MAJOR;
> > > + if ( !sd_alloc_majors() ) return 1;
> > > + }
> > >
> > >   if (!sd_registered) {
> > >   for (i = 0; i < N_USED_SD_MAJORS; i++) {
> > >   if (devfs_register_blkdev(SD_MAJOR(i), "sd", &sd_fops)) {
> > >   printk("Unable to get major %d for SCSI disk\n", SD_MAJOR(i));
> > > + sd_dealloc_majors();
> > >   return 1;
> > >   }
> > >   }
> > > @@ -1166,6 +1210,7 @@
> > >   for (i = 0; i < N_USED_SD_MAJORS; i++) {
> > >   devfs_unregister_blkdev(SD_MAJOR(i), "sd");
> > >   }
> > > + sd_dealloc_majors();
> > >   sd_registered--;
> > >   return 1;
> > >  }
> > > @@ -1373,6 +1418,7 @@
> > >
> > >   scsi_unregister_module(MODULE_SCSI_DEV, &sd_template);
> > >
> > > + sd_dealloc_majors();
> > >   for (i = 0; i < N_USED_SD_MAJORS; i++)
> > >   devfs_unregister_blkdev(SD_MAJOR(i), "sd");
> > >
> > > diff -urN linux-2.4.7/drivers/scsi/sd.h linux/drivers/scsi/sd.h
> > > --- linux-2.4.7/drivers/scsi/sd.h Fri Jul 20 15:55:46 2001
> > > +++ linux/drivers/scsi/sd.h Mon Jul 30 20:09:12 2001
> > > @@ -42,10 +42,14 @@
> > >   */
> > >  extern kdev_t sd_find_target(void *host, int tgt);
> > >
> > > -#define N_SD_MAJORS 8
> > > +#define N_SD_PREASSIGNED_MAJORS 8
> > >
> > > +#ifdef CONFIG_SD_MANY
> > > +#define SD_PARTITION(i) ((sd_devnum_to_index((i)) << 4) | ((i)&0x0f))
> > > +#else
> > >  #define SD_MAJOR_MASK (N_SD_MAJORS - 1)
> > >  #define SD_PARTITION(i) (((MAJOR(i) & SD_MAJOR_MASK) << 8) |
(MINOR(i) &
> > 255))
> > > +#endif
> > >
> > >  #endif
> > >
> > > diff -urN linux-2.4.7/drivers/scsi/sg.c linux/drivers/scsi/sg.c
> > > --- linux-2.4.7/drivers/scsi/sg.c Wed Jul  4 18:39:28 2001
> > > +++ linux/drivers/scsi/sg.c Mon Jul 30 17:57:52 2001
> > > @@ -123,7 +123,6 @@
> > >  {
> > >        tag:"sg",
> > >        scsi_type:0xff,
> > > -      major:SCSI_GENERIC_MAJOR,
> > >        detect:sg_detect,
> > >        init:sg_init,
> > >        finish:sg_finish,
> > > diff -urN linux-2.4.7/drivers/scsi/sr.c linux/drivers/scsi/sr.c
> > > --- linux-2.4.7/drivers/scsi/sr.c Thu Jul  5 14:28:17 2001
> > > +++ linux/drivers/scsi/sr.c Mon Jul 30 17:59:33 2001
> > > @@ -69,12 +69,15 @@
> > >
> > >  static int sr_init_command(Scsi_Cmnd *);
> > >
> > > +static unsigned int sr_major = SCSI_CDROM_MAJOR;
> > > +
> > >  static struct Scsi_Device_Template sr_template =
> > >  {
> > >   name:"cdrom",
> > >   tag:"sr",
> > >   scsi_type:TYPE_ROM,
> > > - major:SCSI_CDROM_MAJOR,
> > > + majors:&sr_major,
> > > + num_majors:1,
> > >   blk:1,
> > >   detect:sr_detect,
> > >   init:sr_init,
> > > diff -urN linux-2.4.7/drivers/scsi/st.c linux/drivers/scsi/st.c
> > > --- linux-2.4.7/drivers/scsi/st.c Fri Jul 20 00:16:32 2001
> > > +++ linux/drivers/scsi/st.c Mon Jul 30 17:58:22 2001
> > > @@ -160,7 +160,6 @@
> > >   name:"tape",
> > >   tag:"st",
> > >   scsi_type:TYPE_TAPE,
> > > - major:SCSI_TAPE_MAJOR,
> > >   detect:st_detect,
> > >   init:st_init,
> > >   attach:st_attach,
> > > diff -urN linux-2.4.7/fs/devfs/base.c linux/fs/devfs/base.c
> > > --- linux-2.4.7/fs/devfs/base.c Wed Jul 11 17:55:41 2001
> > > +++ linux/fs/devfs/base.c Mon Jul 30 19:10:41 2001
> > > @@ -511,6 +511,9 @@
> > >          Removed broken devnum allocation and use
<devfs_alloc_devnum>.
> > >          Fixed old devnum leak by calling new <devfs_dealloc_devnum>.
> > >    v0.107
> > > +    20010712   Richard Gooch <rgooch@atnf.csiro.au>
> > > +        Fixed bug in <devfs_setup> which could hang boot process.
> > > +  v0.108
> > >  */
> > >  #include <linux/types.h>
> > >  #include <linux/errno.h>
> > > @@ -543,7 +546,7 @@
> > >  #include <asm/bitops.h>
> > >  #include <asm/atomic.h>
> > >
> > > -#define DEVFS_VERSION            "0.107 (20010709)"
> > > +#define DEVFS_VERSION            "0.108 (20010712)"
> > >
> > >  #define DEVFS_NAME "devfs"
> > >
> > > @@ -1342,12 +1345,12 @@
> > >       return NULL;
> > >   }
> > >      }
> > > -    de->u.fcb.autogen = 0;
> > > +    de->u.fcb.autogen = FALSE;
> > >      if ( S_ISCHR (mode) || S_ISBLK (mode) )
> > >      {
> > >   de->u.fcb.u.device.major = major;
> > >   de->u.fcb.u.device.minor = minor;
> > > - de->u.fcb.autogen = (devnum == NODEV) ? 0 : 1;
> > > + de->u.fcb.autogen = (devnum == NODEV) ? FALSE : TRUE;
> > >      }
> > >      else if ( S_ISREG (mode) ) de->u.fcb.u.file.size = 0;
> > >      else
> > > @@ -1418,7 +1421,7 @@
> > >      MKDEV (de->u.fcb.u.device.major,
> > >     de->u.fcb.u.device.minor) );
> > >   }
> > > - de->u.fcb.autogen = 0;
> > > + de->u.fcb.autogen = FALSE;
> > >   return;
> > >      }
> > >      if (S_ISLNK (de->mode) && de->registered)
> > > @@ -2063,6 +2066,7 @@
> > >   {"show",      OPTION_SHOW,        &boot_options},
> > >   {"only",      OPTION_ONLY,        &boot_options},
> > >   {"mount",     OPTION_MOUNT,       &boot_options},
> > > + {NULL,        0,                  NULL}
> > >      };
> > >
> > >      while ( (*str != '\0') && !isspace (*str) )
> > > @@ -2074,7 +2078,7 @@
> > >       invert = 1;
> > >       str += 2;
> > >   }
> > > - for (i = 0; i < sizeof (devfs_options_tab); i++)
> > > + for (i = 0; devfs_options_tab[i].name != NULL; i++)
> > >   {
> > >       int len = strlen (devfs_options_tab[i].name);
> > >
> > > diff -urN linux-2.4.7/fs/devfs/util.c linux/fs/devfs/util.c
> > > --- linux-2.4.7/fs/devfs/util.c Wed Jul 11 17:55:41 2001
> > > +++ linux/fs/devfs/util.c Mon Jul 30 18:28:12 2001
> > > @@ -39,6 +39,8 @@
> > >                 Created <devfs_*alloc_major> and
<devfs_*alloc_devnum>.
> > >      20010710   Richard Gooch <rgooch@atnf.csiro.au>
> > >                 Created <devfs_*alloc_unique_number>.
> > > +    20010730   Richard Gooch <rgooch@atnf.csiro.au>
> > > +               Documentation typo fix.
> > >  */
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > > @@ -214,7 +216,7 @@
> > >
> > >  /**
> > >   * devfs_alloc_major - Allocate a major number.
> > > - * @type: The type of the major (DEVFS_SPECIAL_CHR or
> > DEVFS_SPECIAL_BLOCK)
> > > + * @type: The type of the major (DEVFS_SPECIAL_CHR or
DEVFS_SPECIAL_BLK)
> > >
> > >   * Returns the allocated major, else -1 if none are available.
> > >   * This routine is thread safe and does not block.
> > > @@ -238,7 +240,7 @@
> > >
> > >  /**
> > >   * devfs_dealloc_major - Deallocate a major number.
> > > - * @type: The type of the major (DEVFS_SPECIAL_CHR or
> > DEVFS_SPECIAL_BLOCK)
> > > + * @type: The type of the major (DEVFS_SPECIAL_CHR or
DEVFS_SPECIAL_BLK)
> > >   * @major: The major number.
> > >   * This routine is thread safe and does not block.
> > >   */
> > > @@ -282,7 +284,7 @@
> > >
> > >  /**
> > >   * devfs_alloc_devnum - Allocate a device number.
> > > - * @type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLOCK).
> > > + * @type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK).
> > >   *
> > >   * Returns the allocated device number, else NODEV if none are
available.
> > >   * This routine is thread safe and may block.
> > > @@ -347,7 +349,7 @@
> > >
> > >  /**
> > >   * devfs_dealloc_devnum - Dellocate a device number.
> > > - * @type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLOCK).
> > > + * @type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK).
> > >   * @devnum: The device number.
> > >   *
> > >   * This routine is thread safe and does not block.
> > > diff -urN linux-2.4.7/include/linux/blk.h linux/include/linux/blk.h
> > > --- linux-2.4.7/include/linux/blk.h Mon Jul 30 19:20:01 2001
> > > +++ linux/include/linux/blk.h Mon Jul 30 20:05:18 2001
> > > @@ -144,7 +144,11 @@
> > >
> > >  #define DEVICE_NAME "scsidisk"
> > >  #define TIMEOUT_VALUE (2*HZ)
> > > +#ifdef CONFIG_SD_MANY
> > > +#define DEVICE_NR(device) sd_devnum_to_index((device))
> > > +#else
> > >  #define DEVICE_NR(device) (((MAJOR(device) & SD_MAJOR_MASK) << (8 -
4)) +
> > (MINOR(device) >> 4))
> > > +#endif
> > >
> > >  /* Kludge to use the same number for both char and block major
numbers */
> > >  #elif  (MAJOR_NR == MD_MAJOR) && defined(MD_DRIVER)
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-scsi"
in
> > > the body of a message to majordomo@vger.kernel.org
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
>

