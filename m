Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUH1QmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUH1QmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUH1Qkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:40:53 -0400
Received: from mail0.lsil.com ([147.145.40.20]:10982 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S267457AbUH1Qho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:37:44 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC9BB@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Adrian Bunk'" <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       "Mukker, Atul" <Atulm@lsil.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "Jose, Manoj" <Manojj@lsil.com>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: RE: [patch] 2.6.9-rc1-mm1: megaraid_mbox.c compile error with gcc
	 3.4
Date: Sat, 28 Aug 2004 12:29:49 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver and the patches with the re-ordered functions is available at
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.20.3.1/

Please merge to the lk 2.6.8.1 using
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.20.3.1/megaraid2.20.
3.1-lk2.6.8.1.patch.gz or upgrade the existing 2.20.3.0 driver in
2.6.9-rc1-mm1 to 2.20.3.1 using
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.20.3.1/megaraid2.20.
3.0-2.20.3.1.patch.gz

Thanks
-Atul Mukker

> -----Original Message-----
> From: Adrian Bunk [mailto:bunk@fs.tum.de]
> Sent: Saturday, August 28, 2004 5:07 AM
> To: Andrew Morton; Atul.Mukker@lsil.com; Sreenivas.Bagalkote@lsil.com;
> Manoj.Jose@lsil.com
> Cc: linux-kernel@vger.kernel.org; James.Bottomley@SteelEye.com;
> linux-scsi@vger.kernel.org
> Subject: [patch] 2.6.9-rc1-mm1: megaraid_mbox.c compile error with gcc
> 3.4
> 
> 
> On Thu, Aug 26, 2004 at 01:47:45AM -0700, Andrew Morton wrote:
> >...
> > All patches:
> >...
> > bk-scsi.patch
> >...
> 
> This results in many compile errors when using gcc 3.4 
> starting with the 
> following:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/scsi/megaraid/megaraid_mbox.o
> drivers/scsi/megaraid/megaraid_mbox.c: In function 
> `megaraid_queue_command':
> drivers/scsi/megaraid/megaraid_mbox.c:114: sorry, 
> unimplemented: inlining failed
>  in call to 'megaraid_mbox_build_cmd': function body not available
> drivers/scsi/megaraid/megaraid_mbox.c:1410: sorry, 
> unimplemented: called from here
> drivers/scsi/megaraid/megaraid_mbox.c:123: sorry, 
> unimplemented: inlining failed
>  in call to 'megaraid_mbox_runpendq': function body not available
> drivers/scsi/megaraid/megaraid_mbox.c:1413: sorry, 
> unimplemented: called from here
> make[3]: *** [drivers/scsi/megaraid/megaraid_mbox.o] Error 1
> 
> <--  snip  -->
> 
> 
> The patch fixes this by removing the inline's from all 
> functions where 
> the inline function was called before it was defined.
> 
> An alterenate approach would be to reorder the file to move 
> all inline'd 
> functions above their first callers.
> 
> 
> diffstat output:
>  drivers/scsi/megaraid/megaraid_mbox.c |   44 
> +++++++++++++-------------
>  1 files changed, 22 insertions(+), 22 deletions(-)
> 
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
> --- 
> linux-2.6.9-rc1-mm1-full-3.4/drivers/scsi/megaraid/megaraid_mb
> ox.c.old	2004-08-28 10:21:20.000000000 +0200
> +++ 
> linux-2.6.9-rc1-mm1-full-3.4/drivers/scsi/megaraid/megaraid
> _mbox.c	2004-08-28 10:31:23.000000000 +0200
> @@ -110,26 +110,26 @@
>  static int megaraid_queue_command(struct scsi_cmnd *,
>  		void (*)(struct scsi_cmnd *));
>  
> -static inline scb_t *megaraid_mbox_build_cmd(adapter_t *, 
> struct scsi_cmnd *,
> +static scb_t *megaraid_mbox_build_cmd(adapter_t *, struct 
> scsi_cmnd *,
>  		int *);
> -static inline scb_t *megaraid_alloc_scb(adapter_t *, struct 
> scsi_cmnd *);
> -static inline void megaraid_dealloc_scb(adapter_t *, scb_t *);
> -static inline void megaraid_mbox_prepare_pthru(adapter_t *, scb_t *,
> +static scb_t *megaraid_alloc_scb(adapter_t *, struct scsi_cmnd *);
> +static void megaraid_dealloc_scb(adapter_t *, scb_t *);
> +static void megaraid_mbox_prepare_pthru(adapter_t *, scb_t *,
>  		struct scsi_cmnd *);
> -static inline void megaraid_mbox_prepare_epthru(adapter_t *, scb_t *,
> +static void megaraid_mbox_prepare_epthru(adapter_t *, scb_t *,
>  		struct scsi_cmnd *);
> -static inline int megaraid_mbox_mksgl(adapter_t *, scb_t *);
> +static int megaraid_mbox_mksgl(adapter_t *, scb_t *);
>  
> -static inline void megaraid_mbox_runpendq(adapter_t *, scb_t *);
> -static inline int mbox_post_cmd(adapter_t *, scb_t *);
> +static void megaraid_mbox_runpendq(adapter_t *, scb_t *);
> +static int mbox_post_cmd(adapter_t *, scb_t *);
>  
>  static void megaraid_mbox_dpc(unsigned long);
> -static inline void megaraid_mbox_sync_scb(adapter_t *, scb_t *);
> +static void megaraid_mbox_sync_scb(adapter_t *, scb_t *);
>  
>  static irqreturn_t megaraid_isr(int, void *, struct pt_regs *);
> -static inline int megaraid_ack_sequence(adapter_t *);
> +static int megaraid_ack_sequence(adapter_t *);
>  
> -static inline int megaraid_busywait_mbox(mraid_device_t *);
> +static int megaraid_busywait_mbox(mraid_device_t *);
>  
>  static int megaraid_cmm_register(adapter_t *);
>  static int megaraid_cmm_unregister(adapter_t *);
> @@ -1434,7 +1434,7 @@
>   * convert the command issued by mid-layer to format 
> understood by megaraid
>   * firmware. We also complete certain command without 
> sending them to firmware
>   */
> -static inline scb_t *
> +static scb_t *
>  megaraid_mbox_build_cmd(adapter_t *adapter, struct scsi_cmnd 
> *scp, int *busy)
>  {
>  	mraid_device_t		*rdev = ADAP2RAIDDEV(adapter);
> @@ -1809,7 +1809,7 @@
>   * return the scb from the head of the free list. NULL if 
> there are none
>   * available
>   **/
> -static inline scb_t *
> +static scb_t *
>  megaraid_alloc_scb(adapter_t *adapter, struct scsi_cmnd *scp)
>  {
>  	struct list_head	*head = &adapter->kscb_pool;
> @@ -1847,7 +1847,7 @@
>   * NOTE NOTE: Make sure the scb is not on any list before 
> calling this
>   * routine.
>   **/
> -static inline void
> +static void
>  megaraid_dealloc_scb(adapter_t *adapter, scb_t *scb)
>  {
>  	unsigned long		flags;
> @@ -1873,7 +1873,7 @@
>   *
>   * prepare a command for the scsi physical devices
>   */
> -static inline void
> +static void
>  megaraid_mbox_prepare_pthru(adapter_t *adapter, scb_t *scb,
>  		struct scsi_cmnd *scp)
>  {
> @@ -1921,7 +1921,7 @@
>   * prepare a command for the scsi physical devices. This 
> rountine prepares
>   * commands for devices which can take extended CDBs (>10 bytes)
>   */
> -static inline void
> +static void
>  megaraid_mbox_prepare_epthru(adapter_t *adapter, scb_t *scb,
>  		struct scsi_cmnd *scp)
>  {
> @@ -1967,7 +1967,7 @@
>   *
>   * prepare the scatter-gather list
>   */
> -static inline int
> +static int
>  megaraid_mbox_mksgl(adapter_t *adapter, scb_t *scb)
>  {
>  	struct scatterlist	*sgl;
> @@ -2046,7 +2046,7 @@
>   * out from the head of the pending list. If it is 
> successfully issued, the
>   * next SCB is at the head now.
>   */
> -static inline void
> +static void
>  megaraid_mbox_runpendq(adapter_t *adapter, scb_t *scb_q)
>  {
>  	scb_t			*scb;
> @@ -2116,7 +2116,7 @@
>   *
>   * post the command to the controller if mailbox is availble.
>   */
> -static inline int
> +static int
>  mbox_post_cmd(adapter_t *adapter, scb_t *scb)
>  {
>  	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
> @@ -2218,7 +2218,7 @@
>   *
>   * Returns:	1 if the interrupt is valid, 0 otherwise
>   */
> -static inline int
> +static int
>  megaraid_ack_sequence(adapter_t *adapter)
>  {
>  	mraid_device_t		*raid_dev = ADAP2RAIDDEV(adapter);
> @@ -2556,7 +2556,7 @@
>   *
>   * DMA sync if required.
>   */
> -static inline void
> +static void
>  megaraid_mbox_sync_scb(adapter_t *adapter, scb_t *scb)
>  {
>  	mbox_ccb_t	*ccb;
> @@ -3069,7 +3069,7 @@
>   * wait until the controller's mailbox is available to 
> accept more commands.
>   * wait for at most 1 second
>   */
> -static inline int
> +static int
>  megaraid_busywait_mbox(mraid_device_t *raid_dev)
>  {
>  	mbox_t	*mbox = raid_dev->mbox;
> 
